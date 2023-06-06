Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255F724975
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjFFQpy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 12:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFFQpy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 12:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564BBE79;
        Tue,  6 Jun 2023 09:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23C5635B0;
        Tue,  6 Jun 2023 16:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BC5C433EF;
        Tue,  6 Jun 2023 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686069952;
        bh=XGYUzeuyBjUmFprIs2KsG27O/iLzkf4dq24dD5ocyrg=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=gwDbTRqQh3xBIoHS/yG5W5dWo7pswmrBr6u4IGWKYKz2tL7KRHuFoA7jSREWkJ3Qx
         iTBSiyqSIXMAFUKjR2ufkOD+RbBi81U80Mabw6mkVIgHNkkMfvesNRVqtV1jTENHwP
         noLon/bvCAqwTml3VVq0pR3YjezabuEExvUDtm540i3Yv8LuFztfAt7Cl6iA4Eotwg
         L8nSD1tCrqkZ3T6j4qf2/L301vsiSsUvpU216ebqMHgYwk4tu8M7l8djqETAE+SZDX
         ++gOS1W1PNA+XznzO/PN7LydchYLH9sWOSPjr40Bra9Dve8URf1LT4JM9DlBlvJiRY
         je9lM5ekaRN3g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 19:45:46 +0300
Message-Id: <CT5PWWG5KAMV.2PYG7AVFP6A74@suppilovahvero>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lukas@wunner.de>,
        <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
X-Mailer: aerc 0.15.2-33-gedd4752268b2
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <da435e0d-5f22-fac7-bc10-96a0fd4c6d54@kunbus.com>
 <a84c447f-cdfb-d33c-62cb-bb5d9aa8510b@linux.intel.com>
In-Reply-To: <a84c447f-cdfb-d33c-62cb-bb5d9aa8510b@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon May 29, 2023 at 9:46 AM EEST, P=C3=A9ter Ujfalusi wrote:
> I'm surprised that there is a need for a storm detection in the first
> place... Do we have something else on the same IRQ line on the affected
> devices which might have a bug or no driver at all?
> It is hard to believe that a TPM (Trusted Platform Module) is integrated
> so poorly ;)

I mentioned this some emails ago (do not care to look up when does not
matter) and I guess the reason for this might be that a generic solution
compassing all arch's etc. might be tricky to design...

BR, Jarkko
