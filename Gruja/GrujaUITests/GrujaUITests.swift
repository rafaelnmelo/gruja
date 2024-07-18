import XCTest

class when_content_view_is_shown: XCTestCase {
    
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
    }
  
    func test_should_make_sure_that_the_total_text_field_contains_default_value() {
        XCTAssertEqual(contentViewPage.totalTextField.value as! String, "Enter total")
    }
    
    func test_should_make_sure_the_20_percent_default_tip_option_is_selected() {
        let segmentedControlButton = contentViewPage.tipPercentageSegmentedControl.buttons.element(boundBy: 1)
        XCTAssertEqual(segmentedControlButton.label, "20%")
        XCTAssertTrue(segmentedControlButton.isSelected)
    }
    
    override func tearDown() {
        super.tearDown()
        //Clean up
    }
}

class when_calculate_tip_button_is_pressed_for_valid_input: XCTestCase {
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
        
        contentViewPage.totalTextField.tap()
        contentViewPage.totalTextField.typeText("100")
        
        contentViewPage.calculateTipButton.tap()
    }
    
    func test_should_make_sure_that_tip_is_displayed_on_the_screen() {
        let tipText = app.staticTexts["tipText"]
        let _ = tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(tipText.label, "R$ 20,00")
    }
}

class when_calculate_tip_button_is_pressed_for_invalid_input: XCTestCase {
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
        
        contentViewPage.totalTextField.tap()
        contentViewPage.totalTextField.typeText("-100")
        
        contentViewPage.calculateTipButton.tap()
    }
    
    func test_should_clear_tip_label_for_invalid_input() {
        let _ = contentViewPage.tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(contentViewPage.tipText.label, "")
    }
    
    func test_should_display_error_message_for_invalid_input() {
        let _ = contentViewPage.messageText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(contentViewPage.messageText.label, "Invalid Input")
    }
}

