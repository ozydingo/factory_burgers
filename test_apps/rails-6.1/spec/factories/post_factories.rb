FactoryBot.define do
  factory :post do
    association :author, factory: "user"
    title { "Here's the thing" }
    body { "Lorem ipsum, dolor sit amet." }

    trait :long do
      body do
        <<~POST
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis gravida mi nec velit congue, ac vehicula neque suscipit. Ut est magna, placerat sit amet dignissim nec, mollis ac elit. Nam purus arcu, vulputate et gravida non, aliquet eget mauris. Phasellus elementum quis nunc eu lobortis. In hac habitasse platea dictumst. Nam a ante nulla. Ut quis velit blandit, interdum turpis sed, sodales magna. Nunc interdum enim id justo malesuada fermentum. Praesent fermentum augue libero, at gravida mi euismod sit amet. Mauris dictum nulla est, ut molestie purus maximus nec. Ut urna neque, bibendum id arcu eget, finibus consequat elit. Nunc scelerisque sagittis lacus sit amet scelerisque.
        Nulla efficitur maximus augue. Praesent quis pulvinar purus. Curabitur eget porta sapien. Aenean fermentum, eros in pellentesque faucibus, arcu nisi aliquam risus, sed laoreet dolor risus et nunc. Donec interdum nisi ut nulla tincidunt ornare quis a ante. Aenean et est mauris. Curabitur ac ex sit amet dui lacinia blandit sit amet ut neque. Praesent viverra lacus est, a sagittis ligula sagittis non. Morbi bibendum quam ut posuere mollis. Duis et pretium purus, at cursus libero. Donec interdum laoreet quam, vel accumsan elit commodo sed.
        Proin eu felis ut leo malesuada pharetra ut non felis. Aliquam erat volutpat. Pellentesque ac lorem tincidunt, euismod nibh id, malesuada massa. Suspendisse sed elementum purus. Donec et est scelerisque, gravida nulla eleifend, viverra orci. Proin id enim sapien. Nullam ac venenatis leo, et sagittis est. Curabitur vulputate vel massa ac eleifend. Aliquam pellentesque risus in ex ultrices bibendum. Pellentesque quis libero at erat tempus consectetur. Donec interdum neque eget dolor vulputate, in eleifend leo sollicitudin. Nam sed dignissim elit, non dictum nunc. Nam pulvinar orci eu massa auctor maximus. Ut feugiat in mauris at auctor. Mauris lobortis risus at nunc tristique feugiat.
        Aliquam sem nulla, scelerisque id vestibulum vitae, euismod vitae sem. Morbi vulputate leo vel porta gravida. Suspendisse sed ex ut est commodo semper sed in nibh. Phasellus ornare ex vel leo interdum sagittis. Praesent volutpat, quam mollis porttitor dictum, nunc ipsum molestie diam, quis dapibus libero justo nec velit. Etiam sit amet augue eros. Proin mollis, lectus quis pharetra dapibus, mi nisl condimentum dolor, quis imperdiet elit nisi eget diam. Duis nec erat vel libero laoreet tempus. In pretium vel turpis eu efficitur. Nam convallis dolor sed lacinia ornare. Sed bibendum blandit pretium. Praesent vel nibh quis leo eleifend molestie eu a tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consectetur ut nunc sit amet maximus. Duis commodo, justo non malesuada ultricies, turpis nibh blandit lorem, ultrices vestibulum dolor quam ut ipsum.
        Nulla varius sagittis nunc, at condimentum sapien sodales sed. Fusce at pretium mi, sed molestie justo. Quisque quis lobortis sem. Donec tempus posuere arcu, efficitur tincidunt enim maximus at. Aliquam ut elementum neque. Mauris mollis lectus sed orci tincidunt, sed ultrices lectus egestas. Donec et venenatis odio. Proin ultricies, nulla vel aliquet dignissim, tortor erat scelerisque nisi, nec ullamcorper tellus eros vestibulum ante. Aenean posuere venenatis tincidunt. Integer ante massa, porttitor dictum ullamcorper eu, venenatis suscipit lorem. Cras et blandit tellus.
        POST
      end
    end

    trait :very_long do
      body do
        <<~POST
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu sem nec urna vehicula vestibulum vel vel nisi. Duis eget lacus efficitur, pharetra magna in, ornare odio. Ut suscipit, neque vitae vulputate pellentesque, sapien nulla volutpat ligula, at mattis justo ex vitae nibh. Mauris dictum, quam ut tristique scelerisque, mi dui iaculis eros, at vulputate velit mauris sed sapien. Donec mattis eros id ligula pulvinar, eget fringilla ipsum feugiat. In laoreet varius velit, id tincidunt dolor. Donec tempus fermentum tellus, ac pulvinar ante condimentum tincidunt. Duis quis sem nisi. Quisque vestibulum quam magna, quis congue quam condimentum sed. Nam vel convallis nibh, at consectetur lacus. Aliquam mollis pretium ipsum non facilisis. Praesent ornare lacus et enim auctor gravida. Donec ipsum justo, porttitor ut scelerisque eget, fermentum eu est. Quisque consectetur nisl ut erat eleifend ornare. In varius sem a augue ultrices vehicula.
        Vestibulum ac porttitor elit. Fusce consequat, dui eu gravida tempor, erat lacus auctor tellus, sed placerat mi risus vitae sem. Cras vel urna erat. Nullam mollis ultrices arcu, vel posuere mauris rutrum id. Cras imperdiet nisi vitae tincidunt gravida. Vivamus sollicitudin magna felis, quis vulputate neque aliquam quis. Nunc in lectus non tellus lacinia laoreet.
        Suspendisse vitae purus nunc. Etiam sapien lorem, rhoncus quis nibh ac, fringilla imperdiet sem. Sed ultrices egestas sapien sed condimentum. Quisque nec pellentesque neque. Aenean at nisi eros. Nunc tincidunt rutrum dolor vitae vulputate. Nam nulla magna, vestibulum vitae erat at, lacinia dignissim dolor. Nulla facilisi. Donec quis pharetra magna, in efficitur urna. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut rutrum commodo mauris, commodo dapibus est blandit ac.
        Ut sodales purus ullamcorper mattis viverra. Suspendisse sodales sapien quis suscipit sodales. Fusce ut sapien semper dui varius sollicitudin. Sed scelerisque viverra porta. Mauris pulvinar et sem vel pharetra. Fusce ac neque finibus, tempus ex nec, tincidunt elit. Donec vitae eros purus. Proin eget velit sit amet nunc sodales pulvinar.
        Vivamus vulputate nisi non neque faucibus, nec sollicitudin arcu elementum. Mauris id pharetra nunc, id pulvinar odio. Nulla et finibus lorem, in faucibus ipsum. Quisque volutpat sit amet risus ut ornare. Nullam diam purus, aliquet sit amet nisi ac, ornare dapibus risus. Donec venenatis eleifend sem. Sed aliquam dictum dui, a malesuada diam facilisis et. Aenean efficitur laoreet nulla. Pellentesque tempor nunc massa, in convallis enim faucibus nec. Etiam ut libero eros. Nulla aliquam justo at tincidunt vulputate. Donec bibendum feugiat eros nec aliquet. Vestibulum hendrerit, leo eu luctus viverra, ligula lorem ultricies justo, nec viverra dui libero id lacus.
        Aenean tristique est nisi. Aenean tellus massa, dapibus nec massa vitae, aliquet dapibus urna. Cras ac felis bibendum, varius tortor ac, hendrerit lacus. Phasellus malesuada nunc purus, et facilisis purus maximus ut. Sed lacus arcu, mollis in lacus a, molestie dictum lorem. Vestibulum vitae porta nulla, dapibus lobortis augue. Proin fringilla justo eu ligula finibus, quis commodo leo lobortis. Aliquam dolor diam, dignissim vel vehicula at, eleifend nec lorem. Praesent ac interdum metus. Fusce porta ornare metus tincidunt congue. Ut non venenatis nunc, at pretium sem. Cras gravida lobortis dictum. Aenean dapibus risus accumsan lacus tempor, at convallis tortor pulvinar. Sed in tellus ut ante varius bibendum ac eu tellus.
        Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In gravida, ipsum vel ullamcorper egestas, ex massa elementum sapien, non iaculis mi nibh vitae elit. Nunc vestibulum venenatis hendrerit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Duis tortor lacus, dignissim congue massa eu, rutrum lobortis enim. Nam justo massa, interdum a nisl quis, pharetra vulputate mauris. Maecenas ut neque a sapien efficitur ultricies. Morbi augue nisl, bibendum vel consectetur bibendum, ornare vel felis. Integer a nulla tellus. Sed non bibendum tellus, aliquet sodales est. Donec auctor, dolor a porttitor placerat, velit ligula dapibus mi, vitae tincidunt nibh justo ac enim. Etiam non enim vestibulum, ullamcorper justo eget, suscipit augue. Pellentesque diam orci, maximus tempus posuere vel, aliquam eget ante. Praesent posuere sem eu placerat porta. Sed pharetra laoreet interdum. Vestibulum tincidunt, justo a ornare sollicitudin, leo ipsum varius dolor, et eleifend nisl eros in nulla.
        Sed euismod ligula vel odio pellentesque, quis sodales mauris eleifend. Duis in fermentum elit. Ut rutrum est non pulvinar pulvinar. Aenean rhoncus sodales justo eu iaculis. Nulla imperdiet ultricies tempor. Vestibulum porta, massa a imperdiet facilisis, ligula nunc congue nunc, at bibendum lorem massa ut felis. Duis elit diam, placerat in pellentesque ac, sollicitudin quis ante. Sed molestie metus sed sodales semper. Cras eu odio id quam mollis finibus sed ut felis.
        Morbi accumsan ultrices mauris, quis euismod tortor elementum et. Nam maximus tellus justo, varius dapibus magna vulputate a. Donec in lacus sit amet dolor imperdiet aliquet vitae vitae eros. Suspendisse a dictum felis. Nunc bibendum velit eu felis sollicitudin dignissim. Etiam at purus hendrerit, rutrum lorem a, aliquam tortor. Suspendisse id augue mollis, eleifend ante ac, fermentum velit. Nunc quis arcu in nulla placerat facilisis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque aliquet tincidunt orci, eu aliquet ex eleifend ut. Sed ipsum quam, laoreet condimentum nisl a, dapibus suscipit lectus. Vestibulum mattis, augue ut bibendum iaculis, enim tellus vestibulum nulla, id faucibus velit ipsum id ipsum. Mauris id tempus justo. Integer quis lacinia libero, eu egestas velit. Sed venenatis quam sapien, et scelerisque urna molestie eu. Donec semper leo in sem scelerisque, ut auctor ligula accumsan.
        Cras quis tortor nibh. Integer pulvinar placerat lectus, vitae gravida elit ullamcorper in. Ut metus ante, condimentum a nisl quis, interdum viverra eros. Duis id maximus lorem. Suspendisse rutrum libero ac est tempus euismod. Maecenas nec finibus nisi. Vivamus placerat gravida ipsum, nec fringilla leo feugiat in. Cras sit amet neque sit amet mi consectetur mattis. Sed imperdiet ex vel libero congue rutrum. Etiam odio lacus, bibendum at egestas quis, pellentesque non tortor. Pellentesque tellus libero, consectetur tempor pulvinar ac, vulputate at metus. Nulla molestie finibus elit fermentum pretium. Nulla in felis id libero aliquet congue. Nullam accumsan, diam a egestas malesuada, turpis arcu ornare lacus, vel maximus lacus velit id nibh. Proin tincidunt lobortis sapien, non eleifend neque auctor sit amet.
        POST
      end
    end
  end
end