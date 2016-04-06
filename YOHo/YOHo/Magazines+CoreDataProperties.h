//
//  Magazines+CoreDataProperties.h
//  
//
//  Created by mac on 16/4/5.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Magazines.h"

NS_ASSUME_NONNULL_BEGIN

@interface Magazines (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *downloadState;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *progress;
@property (nullable, nonatomic, retain) NSData *resumeData;
@property (nullable, nonatomic, retain) NSString *savePath;

@end

NS_ASSUME_NONNULL_END
