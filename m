Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B67350E28B
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Apr 2022 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiDYOFN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Apr 2022 10:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiDYOFK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Apr 2022 10:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120FD890BF
        for <linux-integrity@vger.kernel.org>; Mon, 25 Apr 2022 07:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1E98615AC
        for <linux-integrity@vger.kernel.org>; Mon, 25 Apr 2022 14:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635F3C385A7;
        Mon, 25 Apr 2022 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650895326;
        bh=U3v0SwBxCiqK51fk9ara615A9ffJerzarhy7LcjPq7w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GY6YOwE9bnRdGJ5+5/atTSua6kTKGERzADbBwUgkJ/mytOW3nZ3NQBZBWPb70/Yng
         +efrek6FHesBfPlSxF/yu4lpfVsh5viqKsXDR7CHP8hTUesnDK5yIq8N0WUmo5a5ns
         LH5SMKBnGwRfGU0UZTNrQO+M0RvU6IISsep2yeQ7u/zVQm8tkNHqoE8CMHHEoa3wTd
         9K4T1DlJgQyUs2QaNm7qcN7jO43ejljRGfoR0iuhk2nMBGb+wiRSjHpnWF74wzSRQt
         rr6qC4HPnB3MytqTxgg8F7wqzP+V4+04D6EsBw8n5pVO6gp25JNMg8Qap+dISa/zLS
         jCpYkrCx4yYvA==
Message-ID: <3991049ce6859f51e5b61e94de269f4672a568cb.camel@kernel.org>
Subject: Re: [PATCH] tpm: Add check for Failure mode for TPM2 modules
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?ISO-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        kernel@axis.com
Date:   Mon, 25 Apr 2022 17:03:33 +0300
In-Reply-To: <20220425102552.663069-1-marten.lindahl@axis.com>
References: <20220425102552.663069-1-marten.lindahl@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-04-25 at 12:25 +0200, M=C3=A5rten Lindahl wrote:
> In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
> TPM2 modules") it was said that:
>=20
> "If the TPM is in Failure mode, it will successfully respond to both
> tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
> is in Failure mode."
>=20
> But a check was never added in the commit when calling
> tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
> This commit corrects this by adding a check.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I think this should actually have the fixes tag. It's a regression,
right? I can add it.

BR, Jarkko
