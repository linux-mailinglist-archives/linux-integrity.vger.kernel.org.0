Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE66EC0D4
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDWPjI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWPjI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 11:39:08 -0400
X-Greylist: delayed 124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Apr 2023 08:39:05 PDT
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE25E51;
        Sun, 23 Apr 2023 08:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1682264195; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Bh7XQtHGggdE7cuEvFrhZ4CIcjkF8HYF7tja5twkCWuPVUzDnBhqbyVYlVtGTLDCNZesXaDB/QmwlzM1D1JpXENQqlvoN6US8w/hWIRgHJh7fpfS2N31xM0vAR7q80NbLMvbFuY0Jkcfd6ZLj0xR/rOISYBo/4d9q6qaKNdOJBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1682264195; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=KP5usS+I85x0A0fFTywcu5eB7jZljNhZSWfv/ljyeL8=; 
        b=Ej7lzvqGGt0ViE7ayEOFLXIWmKKULq7Avt4J43UWUWjfXYHBd+oy2cUA2ijXdgrQkrPqaTcuqt7qrm5zjZEORkPzv8jDyr2Dxb0oUwJsA2kCOhyYaWVI3MRr38tEFKJFWdFUEOpVaNySumCEBbRpe5ifNEBjJgqcwk5MjJHB7Ns=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (31.187.91.190 [31.187.91.190]) by mx.zohomail.com
        with SMTPS id 1682264189997859.8986172259391; Sun, 23 Apr 2023 08:36:29 -0700 (PDT)
Message-ID: <87d022be08cf911178cfb8182598a1689b050845.camel@mniewoehner.de>
Subject: Re: [PATCH v11 00/14] TPM IRQ fixes
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
In-Reply-To: <CS4767IVV0V2.2E9IH70NE7FGQ@suppilovahvero>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
         <4c094418-7725-b815-f1f9-8b12f1ac4d72@gmx.de>
         <c02493fac223707de39e44d51b0a0ce512565250.camel@mniewoehner.de>
         <20230319135338.c7k6r3ws6lby5qgv@kernel.org> <ZEK+w3Q++vu4Kl5x@kernel.org>
         <a93b6222-edda-d43c-f010-a59701f2aeef@gmx.de>
         <CS4767IVV0V2.2E9IH70NE7FGQ@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Sun, 23 Apr 2023 17:36:25 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.44.4 
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2023-04-23 at 17:15 +0300, Jarkko Sakkinen wrote:
> On Sat Apr 22, 2023 at 3:59 AM EEST, Lino Sanfilippo wrote:
> > Hi,
> > 
> > On 21.04.23 18:50, Jarkko Sakkinen wrote:
> > 
> > > 
> > > I tested this with libvirt/QEMU/swtpm and did the following tests:
> > > 
> > > 1. TPM 1.2 suspend/resume.
> > > 2. TPM 2.0 kselftest.
> > > 3. TPM 2.0 suspend/resume + kselftest.
> > > 
> > > I see no issues so I can pick this for my pull request.
> > > 
> > > Tests were performed on top of v6.3-rc7.
> > > 
> > > For all:
> > > 
> > > Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > BR, Jarkko
> > 
> > Thats great, thanks a lot for testing this!
> 
> Thanks for the patience! I'm sorry it took so long but at least all the
> steps in v11 make perfect sense and I see nothing that would rise red
> flags. So we can land this with good confidence I think.
> 
> BR, Jarkko

I wonder, if it makes sense to submit this patch series to longterm and/or at
least stable?

BR Michael

