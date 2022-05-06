Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E161C51D725
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391569AbiEFMC3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385170AbiEFMC3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 08:02:29 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6C1583BB
        for <linux-integrity@vger.kernel.org>; Fri,  6 May 2022 04:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1651838326; x=1683374326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hqaoikTYY0XSPOLEqFdOhBQ/y9tGSU0OMLPapWEpPjE=;
  b=OnLNosTArupzATNwYL+i/ZBjgsJW5MJ27aXWDZczxrcayRA5bK28EC6T
   FqIf5k8CFuN/9ko+dn6jGdmqXito6CtND3upXYXHokNoKoA5i8H3WMOzH
   aANJaMXcizKpPxwrXmqvXofY6DOMMnq9rllzclKeCovnY5+8h8TVOWjXh
   k=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="119484655"
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="119484655"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 13:58:44 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  6 May 2022 13:58:44 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 6 May 2022
 13:58:44 +0200
Received: from smaha-lin-dev01.agb.infineon.com (172.23.8.247) by
 MUCSE818.infineon.com (172.23.29.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 13:58:44 +0200
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
To:     <martenli@axis.com>
CC:     <Marten.Lindahl@axis.com>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <kernel@axis.com>, <linux-integrity@vger.kernel.org>,
        <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: Add check for Failure mode for TPM2 modules
Date:   Fri, 6 May 2022 14:00:41 +0200
Message-ID: <20220506120041.228769-1-stefan.mahnke-hartmann@infineon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YmbDpMUtUK/NrXIY@axis.com>
References: <YmbDpMUtUK/NrXIY@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE816.infineon.com (172.23.29.42) To
 MUCSE818.infineon.com (172.23.29.44)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Mon, Apr 25, 2022 at 04:03:33PM +0200, Jarkko Sakkinen wrote:
> > On Mon, 2022-04-25 at 12:25 +0200, Mårten Lindahl wrote:
> > > In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> > > TPM2 modules") it was said that:
> > > 
> > > "If the TPM is in Failure mode, it will successfully respond to both
> > > tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> > > answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
> > > is in Failure mode."
> > > 
> > > But a check was never added in the commit when calling
> > > tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
> > > This commit corrects this by adding a check.
> > > 
> > > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > I think this should actually have the fixes tag. It's a regression,
> > right? I can add it.
>
> Hi Jarkko!
>
> Thank you. Yes it should have a fixes tag for the mentioned commit.
>
> Kind regards
> Mårten
>
> > 
> > BR, Jarkko

Hi Mårten,

your patch introduces redundant code. The code block of the if below
contains exactly the same code.

Additionally, your patch masks a bug (derefencing uninitialized
memory). I will send a patch set shortly.

Regards
Stefan
