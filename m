Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3474570B6
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jun 2019 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfFZSfS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jun 2019 14:35:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47084 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZSfS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jun 2019 14:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=04YOcDLjot3ihaIK+O8DqmUkZ1/ZeU9r17gmohos7MI=; b=JE9favaLmIW7xwmMIJXeyJ+wxh
        tit/6UQDt1ktt1DQKuSCV53K0rWRIhVovN8QuxRAI/HItb1tDl9Zrb/F9pJBKV5n1O0oyYM3jGXb/
        DG64MCratex7p/P8h69Fo5+YUzvIeBo28M8TMsy9f0fGDjNw/VLNz4BCmMw2OUQGhsunbazxxvw7a
        Ueggf1oUYsxLLMyDM4bn+TB0JekVqknnw/NoxT4pQITGWL2Mfs3y2DY/9blejIrClJv1t5cP1nXVj
        0yoUwseIxWtOE4FJKFfeVLp7NkMPvyOgUP1/C+Q41HbAk3juTRcmyIill8MnuqOKn4zeUCXhXiZUV
        y+PYeIwg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgClH-000123-9D; Wed, 26 Jun 2019 18:35:15 +0000
Subject: Re: linux-next: Tree for Jun 26 (security/integrity/ima/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <20190626231617.1e858da3@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ee503bc1-a588-81f5-47e0-1762f590662f@infradead.org>
Date:   Wed, 26 Jun 2019 11:35:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190626231617.1e858da3@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/26/19 6:16 AM, Stephen Rothwell wrote:
> Hi all,
> 
> The sparc64 builds are broken in this tree, sorry.
> 
> Changes since 20190625:
> 

on x86_64:

11 warnings like this one (in a randconfig build):

  CC      security/integrity/ima/ima_fs.o
In file included from ../security/integrity/ima/ima.h:25:0,
                 from ../security/integrity/ima/ima_fs.c:26:
../security/integrity/ima/../integrity.h:170:18: warning: ‘struct key_acl’ declared inside parameter list [enabled by default]
           struct key_acl *acl)
                  ^
../security/integrity/ima/../integrity.h:170:18: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]



-- 
~Randy
