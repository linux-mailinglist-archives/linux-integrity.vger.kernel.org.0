Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5641050E4C9
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Apr 2022 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiDYPzL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Apr 2022 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiDYPzK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Apr 2022 11:55:10 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F8C3A5CB
        for <linux-integrity@vger.kernel.org>; Mon, 25 Apr 2022 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1650901926;
  x=1682437926;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=0/bhcxUfijXPvjf0QgtoxndD2u8egCKZotzU4MlYUw0=;
  b=XTCOaoTIlc6kTA8kCAGg4EL5kNmv8b7DryXo8mxj7+lHhmAx/+oKBvDb
   ouC0ze8wyXIMtIT8y0CRNqTCtdINPlKkFDy8KQQvPt9LCwwktMwKFYhM2
   8DDbGQr72zzCCwCAi/spltZUWgXN2Sqpv1DTSC2hd1e/JeTltD9oRKUyn
   Pmy/74PjsJWoEe+H8V1/Ahn4q+UqGlAItxJ8CniV+h0tTCCt5u05dhZDU
   YJehD7zstmiIWMyaY6DEzE5EiyNOsBbWlfuJx9tuNFUEr4S38tdW5GdVM
   s+eOpgTDJ5DsJdo2pH1NmQBWUrEYMOXZ5sJZJEuKXqpimO6EgCi4Ru5Y1
   g==;
Date:   Mon, 25 Apr 2022 17:52:04 +0200
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH] tpm: Add check for Failure mode for TPM2 modules
Message-ID: <YmbDpMUtUK/NrXIY@axis.com>
References: <20220425102552.663069-1-marten.lindahl@axis.com>
 <3991049ce6859f51e5b61e94de269f4672a568cb.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3991049ce6859f51e5b61e94de269f4672a568cb.camel@kernel.org>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 25, 2022 at 04:03:33PM +0200, Jarkko Sakkinen wrote:
> On Mon, 2022-04-25 at 12:25 +0200, Mårten Lindahl wrote:
> > In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> > TPM2 modules") it was said that:
> > 
> > "If the TPM is in Failure mode, it will successfully respond to both
> > tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> > answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
> > is in Failure mode."
> > 
> > But a check was never added in the commit when calling
> > tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
> > This commit corrects this by adding a check.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I think this should actually have the fixes tag. It's a regression,
> right? I can add it.

Hi Jarkko!

Thank you. Yes it should have a fixes tag for the mentioned commit.

Kind regards
Mårten

> 
> BR, Jarkko
