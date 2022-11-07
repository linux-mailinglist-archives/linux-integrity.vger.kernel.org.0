Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB7761F9FF
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 17:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiKGQgE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 11:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKGQgD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 11:36:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82313BBF
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 08:36:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4640DB81151
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 16:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC274C433C1;
        Mon,  7 Nov 2022 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667838960;
        bh=E5LWhJIStzWB/4UHx5g0PHwvRXxThGIqiEtLJZhSyGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0wabPt3wuWdHW2zIsuMmlPNiYzt8vzEsfXCvBfUiBH7PW58z3hgrvzKt26YWi2XI
         NEh2UneJXS3nz9mHQwj30mq7mZw10M7TZGkEWJ+Ss+R6BGuaalin+YxpNVFsHL+vI0
         5W4hdxdjnFWprgmmabtqcnlU00KbK5wn5FKZloWtgpxnf+gccK0GTasuHCioEHLm5f
         KNK1JXNSlTAzOkFDLtaFAsuSDmw8QyatjQboPD4HTncBLnYFGy5q23LwMaDKO2wYR4
         ZGkPKxi9Q66Nffhymsqt7XeUgGM18+1x95u4lMa0lKG7d1TtTIrcsY9S03tQ3SbjVA
         cFqJ1QrTe6ekg==
Date:   Mon, 7 Nov 2022 18:35:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jan =?utf-8?B?RMSFYnJvxZs=?= <jsd@semihalf.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
Subject: Re: [PATCH v2 3/3] char: tpm: cr50: Move i2c locking to
 request/relinquish locality ops
Message-ID: <Y2kz6q9oPrGTRebD@kernel.org>
References: <20221103145450.1409273-1-jsd@semihalf.com>
 <20221103145450.1409273-4-jsd@semihalf.com>
 <Y2jOXcsXCGyYtCR9@kernel.org>
 <CAOtMz3PpurnM8je0o8zSHFEyUCeiyVeZfU1-=vsO6uB2+e0O8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOtMz3PpurnM8je0o8zSHFEyUCeiyVeZfU1-=vsO6uB2+e0O8w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 07, 2022 at 10:47:44AM +0100, Jan Dąbroś wrote:
> > On Thu, Nov 03, 2022 at 03:54:50PM +0100, Jan Dabros wrote:
> > > Move i2c locking primitives to request_locality and relinquish_locality
> > > callbacks, what effectively blocks TPM bus for the whole duration of
> > > logical TPM operation.
> > >
> > > With this in place, cr50-equipped TPM may be shared with external CPUs -
> > > assuming that underneath i2c controller driver is aware of this setup
> > > (see i2c-designware-amdpsp as an example).
> >
> > Nit: s/CPUs/peripherals/ ? I'm not sure why you want to emphasize external
> > chips having CPU.
> 
> My point was that we can have a multi-controller setup and each
> controller may work with the TPM chip, so let me s/CPUs/controllers/.

ack

BR, Jarkko
