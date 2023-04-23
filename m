Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2771A6EBD3A
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 07:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjDWFig (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 01:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWFif (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 01:38:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DF1987;
        Sat, 22 Apr 2023 22:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 825E060B56;
        Sun, 23 Apr 2023 05:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF6EC433D2;
        Sun, 23 Apr 2023 05:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682228313;
        bh=jKBT3M4WsVf8+YXtMpgMXF2xTajOHL++vIkdz8yvVtE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GXRrVZsPPDG8abTVwl8Q68XjpR+pSgIH5/5WrScI2sQC36jDB8AgQPBgbSSXUs+Vb
         3ZJoQdwcjbikXeHuOmecOOyeD0wTAxKfHrjE7xtYphTXWyueUZPv3YXbjk/qb+hijn
         gHhF03H5qACCYdrqaTP3TzRNUvWuyC6gEjZ1p98SdmMTbOjIiizsHnLyZLIAtyv4Rn
         Ipz6hfYC26F+a7wGVJGX3jAYxn3O4yO3J82YXcgv26dVeCC0u4skqsD1ULN/mUg2Fv
         rXirZRfpkqGRNryZIpv0mO78LTAymvjlUzUfAOkFQqtgbxvHDgQtHy8zYGkN+OhciT
         CTbwbz/M+kduw==
Message-ID: <b1f3b34ec40b86fe74c128cdcd549a294da122f7.camel@kernel.org>
Subject: Re: [PATCH v4 12/13] tpm: add the null key name as a sysfs export
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 23 Apr 2023 08:38:30 +0300
In-Reply-To: <20230403214003.32093-13-James.Bottomley@HansenPartnership.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
         <20230403214003.32093-13-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-04-03 at 17:40 -0400, James Bottomley wrote:
> This is the last component of encrypted tpm2 session handling that
> allows us to verify from userspace that the key derived from the NULL
> seed genuinely belongs to the TPM and has not been spoofed.

How would you do this in practice with the help of this file?

The current description does not make a case to have this file, unless
it is supported by an usage example to do what you claim above.

BR, Jarkko
