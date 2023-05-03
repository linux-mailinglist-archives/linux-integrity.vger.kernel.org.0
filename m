Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30C6F5727
	for <lists+linux-integrity@lfdr.de>; Wed,  3 May 2023 13:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjECL3q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 May 2023 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjECL3o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 May 2023 07:29:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A4D44BE;
        Wed,  3 May 2023 04:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1FAF60EC7;
        Wed,  3 May 2023 11:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3200AC433D2;
        Wed,  3 May 2023 11:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683113383;
        bh=2YSiaSC3B5DCUulsh1GcXovI6CGQah7Ep3LwQ6lewa8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Mu859I0Rpu7B3Zqjo5bERb9Wn50H5yzPthZzeBS2wuUc0wiDxOwJpwhqIplFaUeE/
         YmI16FvU17ZF9DxHSxcDfe/Yw5YOAg5QOAi3rpFGpvpAgEQBzzXoUiJTAPB9mxg+5i
         tIAHouRmNmrLE+PmR0ee8lnHGZyyUBzrW8dkx9QoO2YnTOnDLoQ+4V22YckJe3BFcm
         6xkHEvV0pi7gMYh1HYO6uLwMLtx87onfJXYhWKClVbrRAnh2YchxhsQIORGcXm0YGV
         GCCKZ0+K9who0tgN1enZkne/UzpoJRGflIbainvtmvxsvs6iWeRhvOEo0xtRJjOVFN
         cH9Bu3OCiO59g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 03 May 2023 14:29:40 +0300
Message-Id: <CSCLWCIOO1AL.3844034WWD0MT@suppilovahvero>
Subject: Re: [PATCH v4 04/13] tpm: add buffer handling for TPM2B types
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Stefan Berger" <stefanb@linux.ibm.com>,
        "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Cc:     <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-5-James.Bottomley@HansenPartnership.com>
 <ebfdf8fc-2253-b8a7-b403-29a5916db2f2@linux.ibm.com>
In-Reply-To: <ebfdf8fc-2253-b8a7-b403-29a5916db2f2@linux.ibm.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 2, 2023 at 6:43 PM EEST, Stefan Berger wrote:
> > +void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
> > +{
> > +	u16 len =3D tpm_buf_length(tpm2b);
> > +
>
> if (tpm2b->flags & TPM_BUF_OVERFLOW) {
>      buf->flags |=3D TPM_BUF_OVERFLOW;
>      return;
> }
>
> > +	tpm_buf_append_u16(buf, len);
> > +	tpm_buf_append(buf, tpm_buf_data(tpm2b), len);
>
>
> > +	/* clear the buf for reuse */
> > +	tpm_buf_reset_int(tpm2b);

This should only append. Unpredictable side-effect like this, will=20
add by factors to the time spent maintaining all this.

For any extra steps, do them in the call site.

BR, Jarkko
