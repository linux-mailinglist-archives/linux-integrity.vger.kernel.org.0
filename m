Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1C724966
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjFFQmM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjFFQmK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 12:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4642E62;
        Tue,  6 Jun 2023 09:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D2D762B21;
        Tue,  6 Jun 2023 16:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD03C433D2;
        Tue,  6 Jun 2023 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686069728;
        bh=j1m4n2Ft+Okmau+IY+Kq7vY9Ls9xpmV6RhwDX07Oe10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpCebbSXqe7rCxSSKi8VxZhoONsd+ZPxJQO5KyAk/KNmGMx4Ry7ExyC1qrrnb1reG
         t1hRLj2ewsrwNjDK0byKugqoA609VyqhKy0egcHCfF7GJQCpLAo7B7lctxt9rg3rqO
         aQp3A3KGie33fnuSVMoBqRKtr7qi6fzuKDAooWe5R8GCeno4LmUseur0H4XFuG3ATd
         yRuUXlFz0YNkWCuM0mnB0wIxSf0Dl+ftt98/HArJ0pocLJNMVvSf+40Plnxacp1jQ2
         DXT52cJovReLE3bGtoPHQghBMwVpjUHufaWvb0Sm9Z+UX5ngbt4J0WfTC6fUzns9Tc
         n4DgCVCk6alGQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 19:42:03 +0300
Message-Id: <CT5PU1RV2X20.3AYQOV5CF0EIH@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lino Sanfilippo" <LinoSanfilippo@gmx.de>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lukas@wunner.de>,
        <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
X-Mailer: aerc 0.15.2-33-gedd4752268b2
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <da435e0d-5f22-fac7-bc10-96a0fd4c6d54@kunbus.com>
 <a84c447f-cdfb-d33c-62cb-bb5d9aa8510b@linux.intel.com>
 <3d350827-795e-8277-a209-1c1d33ca57fa@gmx.de>
In-Reply-To: <3d350827-795e-8277-a209-1c1d33ca57fa@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon May 29, 2023 at 4:15 PM EEST, Lino Sanfilippo wrote:
> > Except that if the line got the spurious designation in core, the
> > interrupt line will be disabled while the TPM driver will think that it
> > is still using IRQ mode and will not switch to polling.
>
> In the case that an interrupt storm cant be detected (since there might n=
ot even
> be one) I am fine with adding a quirk.

Speaking of generic vs quirk (if storm can be detected): detection
should be eager as ever possible. Too eager does not cause systems
failing.

This way I think we can converge to stability fast as possible.

Then, later on, if a system where interrupts should work but the
detection disables interrupts we can either make the fixed threshold
less eager, or add a tuning parameter to sysfs.

BR, Jarkko
