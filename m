Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478B16564E3
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Dec 2022 21:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiLZUGb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Dec 2022 15:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLZUGa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Dec 2022 15:06:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27199310;
        Mon, 26 Dec 2022 12:06:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC9C7B80D6E;
        Mon, 26 Dec 2022 20:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A36C433D2;
        Mon, 26 Dec 2022 20:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672085187;
        bh=i/+iCN3V0qJo7Kx2tgwHs7KV6/3d8Eqm1Fc+T1qjgu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDEpFF4wVi4iq7cwLKv4yZkMWdYyTDVG9HDPILZrBl0x1lJQ1KQxXpx0C9qcdcooC
         Lw0R6qPbQdPR+U4JpO4JhNMV69BIJuOxdTis/paE5QFz22y9oPCD4/UU+Qd+Zv7NYQ
         3bm7/kH/Z1klSTKi4TWPEvkFp214xTDUuFuF90i/T+Qa2qT0HzxrOs4YsXIUKUAZ+9
         oxNVb3YKy8DA/Prac4hacU7OUjTrCmt5RDu5GiaWzMlivPlG/kQ/F72BEEasFXFysh
         YUGcDfWDFZMIohKTtYxVHty7Bte5yGhXIXIBpCofvn4IszaDplMffv+vuykCvo3N8L
         j2pmbOz+kMaYA==
Date:   Mon, 26 Dec 2022 20:06:21 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 03/11] tpm: add cursor based buffer functions for
 response parsing
Message-ID: <Y6n+vZSdE5KEZ4eJ@kernel.org>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
 <20221209160611.30207-4-James.Bottomley@HansenPartnership.com>
 <Y5Z62HPEDHGaK+Uq@kernel.org>
 <08f138d9df19b508bc4892d34f117ac15db9570a.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08f138d9df19b508bc4892d34f117ac15db9570a.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 11, 2022 at 10:13:12PM -0500, James Bottomley wrote:
> On Mon, 2022-12-12 at 00:50 +0000, Jarkko Sakkinen wrote:
> > On Fri, Dec 09, 2022 at 11:06:03AM -0500, James Bottomley wrote:
> > > It's very convenient when parsing responses to have a cursor you
> > > simply move over the response extracting the data.  Add such cursor
> > > functions for the TPM unsigned integer types.
> > > 
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > 
> > Saying that something is convenient is not really an argument.
> > 
> > What you are going to use it for? Is it complex enough that what we
> > have not doesn't scale. I'd just answer these questions and write
> > more reasonable commit message.
> 
> It's all used int patch 6 which gets into the complex building of
> authenticated and hmac'd requests and responses via sessions using
> these primitives.

Again state obvious, even if you think it is obvious. It is really useful
to have that kind of that as refresher in the commit log.

I'm setting rpi 3b + tpm2 chip gpio to try this out. I thought it would be
a cool test sytem because later on I can test both fTPM in TZ and SPI dTPM
with it...

BR, Jarkko
