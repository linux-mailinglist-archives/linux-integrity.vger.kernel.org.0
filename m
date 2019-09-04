Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5EA7B0B
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Sep 2019 07:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfIDF6d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Sep 2019 01:58:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37454 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDF6d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Sep 2019 01:58:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id r195so2022318wme.2
        for <linux-integrity@vger.kernel.org>; Tue, 03 Sep 2019 22:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gnwgyVoah+fGgnH8v7uYo3MPpi6uERiS+qX52ylx2Mg=;
        b=kjEO+EV4XrFRvw4SlcdUs7taXE9SrlrbdzqTN7m/ixnW8CTQ+iQfXowyRfapEJI8IZ
         Mwac5jox5/k41RIE8C66b8PZHwoNNksofOsFz4JgE2beUN+F52PrRQoh5yG6pQxwJR1s
         t9FiWzow3w0ajWDDOBI8Hey6ofYCSY6U4YSFIVKxSuuXS1yBZ9IVKJogECNH/4gzLmtU
         PO42N1AKPv8Tv6VBOa3rTJhTN2JieItTHv9jkdyOZ2SJajBtOLxkKLEfzQu0Yx04tXCu
         mRa/YLy6S5+u/0GUqqlCdI9pFdDnMAnI/BZa7mF2i/qZ0N9fFqJOBEo4vqu+uF1SHsO1
         TUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gnwgyVoah+fGgnH8v7uYo3MPpi6uERiS+qX52ylx2Mg=;
        b=gQu/t3jFLH44NYL9/nijfX9lwZ++/ozKfdR+Ha85CX3z+EvqeYv6Vdl7BdyCraOwLT
         TBugMBo7Mo++PFBCcOCsAxi3UAflxScuEogse5oCkVbVNp3KrrmbSR3fCaGGvBqnRdyi
         pcJZh5Qbq+69PWO2BYeg+w6LCy7JVBvFqjwLri16OBB5zt65C8DZSnK3bXyt7+ky9cd9
         Sy9dAljle62LGLZ2AANwBEMO1D/RWJkOi3nFqenqmr9t5WlE48GEnkOoJaojV2wT28om
         n6apqFGLuiojDdx963UUdwwu+s5IjfVuI6vg6xDECV0swunG4xnskYazxgjdQtexhKlx
         YMNA==
X-Gm-Message-State: APjAAAXLgvrjncrO69zaiTEWZ0itS/UARWiuxvjVC+752C1bDq7Mo4Wy
        JL5AICQm9CBcU6RpZHmztcyal/+pFgM=
X-Google-Smtp-Source: APXvYqysUJTvdCEB8mHFrpbGWbngB0Wtog6GhBl/uiI4klO2J5Za37fJFE/o7SMv09t+8JckinRTaw==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr2948970wmj.142.1567576711594;
        Tue, 03 Sep 2019 22:58:31 -0700 (PDT)
Received: from ziepe.ca ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id j1sm12984655wrg.24.2019.09.03.22.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 22:58:30 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i5OJJ-00012i-QG; Wed, 04 Sep 2019 02:58:29 -0300
Date:   Wed, 4 Sep 2019 02:58:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jordan Hand <jorhand@linux.microsoft.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190904055829.GA3936@ziepe.ca>
References: <20190827010559.GA31752@ziepe.ca>
 <1567007592.6115.58.camel@linux.ibm.com>
 <20190828161502.GC933@ziepe.ca>
 <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
 <20190902192632.GB5393@ziepe.ca>
 <1567460118.10024.316.camel@linux.ibm.com>
 <20190903055523.GA4500@ziepe.ca>
 <bc9ab35e-997c-b107-3073-d5150de063d0@intel.com>
 <fe908209-3752-19b2-2652-79fb75f69e2b@linux.microsoft.com>
 <1567553383.4937.29.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567553383.4937.29.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 03, 2019 at 07:29:43PM -0400, Mimi Zohar wrote:

> This discussion is going around in circles.  There are enough people
> asking that the kernel provide at least the TPM version (eg. TPM 1.2
> or TPM 2.0).  Userspace applications/regression tests shouldn't have
> to figure out the TPM version by sending a TPM command and seeing if
> it fails.  That really isn't asking a lot.

A single version number could be appropriate for sysfs
 
> I would also prefer not having to be dependent on a userspace
> application to read the TPM PCRs in order to verify the IMA
> measurement list.

Why?

Jason
