//
//  MSXmlParser.m
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/19/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import "MSXmlParser.h"

@interface MSXmlParser ()<NSXMLParserDelegate>
@property (nonatomic, strong) NSMutableString *lyricsString;
@property (nonatomic, assign) BOOL elementFound;

@end

@implementation MSXmlParser


- (NSString *)getvalueForLyrics:(NSData *)dataToBeparsed;
 {
    
     NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithData:dataToBeparsed];
     xmlparser.delegate = self;
     [xmlparser parse];
     return @"";
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"lyrics"]) {
        self.lyricsString = [[NSMutableString alloc]init];
        self.elementFound = TRUE;
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.elementFound) {
        [self.lyricsString appendString:string];
    }
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"lyrics"]  && self.elementFound) {
        
        self.callBack(self.lyricsString);
        self.elementFound = FALSE;
    }
}
@end
