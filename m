Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5B4BAA77
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Feb 2022 20:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiBQT6g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Feb 2022 14:58:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiBQT6f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Feb 2022 14:58:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7086D289A4;
        Thu, 17 Feb 2022 11:58:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C62CB821B4;
        Thu, 17 Feb 2022 19:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA72C340E8;
        Thu, 17 Feb 2022 19:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645127897;
        bh=tIS1dG2zy1RRVA9bGHHwQ8vHAQt589WIAKZ0K8nnK9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQ2o3jDKhjfTmO1B8QNxXTbawirq/JvPaNVCKbG/1MmnLnvEBGkZjQtv5qcwXDefX
         EDxAs9yAq3rt4vjzibnccRr1nTecBADIjqqzN2dx8XGeILA3w/ELpZ73JPWVjI9HOy
         f3Y5Ia3wBxh1DZGlzT9SzGERZVvTb2m3nru6INvtl5lBO1lyT+fgI6yqr6edmpmYRE
         Yjvj4SVfJKwTKt1WSjyuYSE8u+dq3+bGbwK8u0eMv+1bou9m4Z2g1oVNof6xiWHf9c
         nxQGVullUol7/LIVSinq9JecwyEPmgZkJ7M2MkFCVTb54T/R8/cwopRLJOMNXn9uCU
         u8OgfNrE8rzIA==
Date:   Thu, 17 Feb 2022 20:58:52 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andreas Rammhold <andreas@rammhold.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v8 0/5] Enable root to update the blacklist keyring
Message-ID: <Yg6o/ARtOIwuBFsW@iki.fi>
References: <20210712170313.884724-1-mic@digikod.net>
 <7e8d27da-b5d4-e42c-af01-5c03a7f36a6b@digikod.net>
 <YcGVZitNa23PCSFV@iki.fi>
 <5030a9ff-a1d1-a9bd-902a-77c3d1d87446@digikod.net>
 <Ydc/E3S2vmtDOnpw@iki.fi>
 <YddADJJNLDlQAYRW@iki.fi>
 <86c5010e-a926-023a-8915-d6605cfc4f0a@digikod.net>
 <e4707df2-ecc2-0471-87fc-c54e774fe315@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4707df2-ecc2-0471-87fc-c54e774fe315@digikod.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 31, 2022 at 12:33:51PM +0100, Mickaël Salaün wrote:
> 
> On 07/01/2022 13:14, Mickaël Salaün wrote:
> > 
> > On 06/01/2022 20:16, Jarkko Sakkinen wrote:
> > > On Thu, Jan 06, 2022 at 09:12:22PM +0200, Jarkko Sakkinen wrote:
> > > > On Tue, Jan 04, 2022 at 04:56:36PM +0100, Mickaël Salaün wrote:
> > > > > 
> > > > > On 21/12/2021 09:50, Jarkko Sakkinen wrote:
> > > > > > On Mon, Dec 13, 2021 at 04:30:29PM +0100, Mickaël Salaün wrote:
> > > > > > > Hi Jarkko,
> > > > > > > 
> > > > > > > Since everyone seems OK with this and had plenty of
> > > > > > > time to complain, could
> > > > > > > you please take this patch series in your tree? It still applies on
> > > > > > > v5.16-rc5 and it is really important to us. Please
> > > > > > > let me know if you need
> > > > > > > something more.
> > > > > > > 
> > > > > > > Regards,
> > > > > > >    Mickaël
> > > > > > 
> > > > > > I'm off-work up until end of the year, i.e. I will
> > > > > > address only important
> > > > > > bug fixes and v5.16 up until that.
> > > > > > 
> > > > > > If any of the patches is yet missing my ack, feel free to
> > > > > > 
> > > > > > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > 
> > > > > Thanks Jarkko. Can you please take it into your tree?
> > > > 
> > > > I can yes, as I need to anyway do a revised PR for v5.17, as one commit
> > > > in my first trial had a truncated fixes tag.
> > > 
> > > Please check:
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > > 
> > > /Jarkko
> > 
> > Great, thanks!
> 
> Hi Jarkko,
> 
> I noticed your commits https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=3ec9c3a0531ac868422be3b12fc17310ed8c07dc
> are no more referenced in your tree. Is there an issue?

This must be some sort of mistake I've made. I'll re-apply the patches.
Sorry about this.

BR, Jarkko
