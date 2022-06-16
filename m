Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6430054E163
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376290AbiFPNEO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jun 2022 09:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiFPNEO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jun 2022 09:04:14 -0400
Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCDD394;
        Thu, 16 Jun 2022 06:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1655384636; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=AEN95sGjxRSbBuRwqaRVyJYQx25EMLOa61YyBMDj28YVFphVir9d9Kg5QKq7DkCGgmIFcafpxuTO+ZwLmPzfzn9rxn1/3PGgZYzHT9I+ZB5+38Q37n5ksSxW9ogM5OLdbv0yN4IBqOkaKefhR3X3iFxfjaACztpDX2hIP77d0r0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1655384636; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=RGG6vIU0Ipg7U+iqtSPlaA0Lh59OCg08S0bLfZinpTo=; 
        b=YGxKoJbjhhk3pRah/STeBwuMkeB9nvR+j4UudtGsp4p0oxhbUfjzGRDM5zNp6zEq1wLbAA8ZUKcQmgKsv2UAx3habCRGhV+S6eHhx0+iE9ZmG+PASRk/5uJAcAtR3BRf50ZeFK65tIyIRmnkRXhw84PCh0mcquqbtjnf7REypmw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (185.31.62.161 [185.31.62.161]) by mx.zohomail.com
        with SMTPS id 1655384633496875.2065492508191; Thu, 16 Jun 2022 06:03:53 -0700 (PDT)
Message-ID: <8ed1c322b6f3dc36427c6a5704df0caab2dcec11.camel@mniewoehner.de>
Subject: Re: [PATCH v5 10/10] tpm, tpm_tis: Enable interrupt test
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James.Bottomley@hansenpartnership.com,
        twawrzynczak <twawrzynczak@chromium.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
In-Reply-To: <1c90aba2-5874-7251-ff19-4b6c5bc19962@gmx.de>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
         <20220610110846.8307-11-LinoSanfilippo@gmx.de> <YqokW/cNLrrsZ2ib@iki.fi>
         <c610a318258198f72a53541c551c0c595a205329.camel@mniewoehner.de>
         <1c90aba2-5874-7251-ff19-4b6c5bc19962@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 16 Jun 2022 15:03:49 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.42.2 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lino,

On Thu, 2022-06-16 at 01:30 +0200, Lino Sanfilippo wrote:
> 
> Hi Michael,
> 
> On 15.06.22 at 23:54, Michael Niewöhner wrote:
> 
> > 
> > Hi guys,
> > 
> > for me this series causes boot problems - somehow feels like an interrupt
> > storm...
> 
> 
> Thanks for this info. Which hardware do you use?
> 
> > Not sure yet, which commit is causing that
> > @Tim could you test on any of your devices, please?
> > 
> > BR
> > Michael
> > 
> 
> Regards,
> Lino

looks like something was wrong with the devices firmware... I flashed a fresh
image and everything is totally fine now - TPM gets detected without the
"interrupts not working" error! :-)

Test device: Clevo L140MU, FW v1.07.12, TPM 2.0 Infineon SLB9670 (SPI)

BR
Michael
