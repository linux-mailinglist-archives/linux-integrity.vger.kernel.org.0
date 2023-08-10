Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA64B777C42
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjHJPfC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjHJPev (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 11:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C82126B9
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 08:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D096602D
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 15:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B698C433C8;
        Thu, 10 Aug 2023 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691681690;
        bh=sJEUIcfyHGNVmaSjnb5C3KI8Ypega9MBn0E1l0/vS6A=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=tj1To1HZPNUptgNWInng8wECPtFKth9yYTR9iKnXUkq9x956wpWuFeCKksYhOQ3vH
         32SSbOANc+G6GBVDtZrpYQYWPLeyq5lhU/hd4GtgezElCxz1qpRZNOkcpK3q+XeOn7
         u6b/ivoe7s9T5fhQAzp8jRjER2monHxBjh7l/nFlCFKs7lWI8NmsLyEpXSyRzulNVv
         2ioM5OlDfrsrt0jI+0o7h05dqvRibVp6JzxhS6JUx+SpZX48l6TXqFH16Rbyz7fI3y
         pOlUdv67Yv2wXe5356Xep3J/CTBjDE1rkoI+83wlg5uPt+eY7ur6gNOESRiUGCZook
         QlXbCp9+fuqPw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:34:46 +0300
Message-Id: <CUOZ3Y8AGTLS.3RMS4YJUJME88@wks-101042-mac.ad.tuni.fi>
To:     "Nayna" <nayna@linux.vnet.ibm.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Build failure on tpmdd master branch
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <ebe1d154-962b-4a8b-ad08-b26e99804c1b@linux.vnet.ibm.com>
In-Reply-To: <ebe1d154-962b-4a8b-ad08-b26e99804c1b@linux.vnet.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Aug 8, 2023 at 4:40 PM EEST, Nayna wrote:
> Hi Jarkko,
>
> I rebased the "Enable loading local and third party keys on PowerVM=20
> guest"(=20
> https://lore.kernel.org/linux-integrity/20230714153435.28155-1-nayna@linu=
x.ibm.com/)=20
> on top of tpmdd master branch.
>
> The build is failing due to commit cfa7522f280a ("sysctl: set variable=20
> key_sysctls storage-class-specifier to static"). A patch with the same=20
> subject line is already in your tree. Refer to commit 0de030b30823=20
> ("sysctl: set variable key_sysctls storage-class-specifier to static").
>
> Thanks & Regards,
>
>  =C2=A0=C2=A0=C2=A0=C2=A0 - Nayna

Thanks, I'll take a look!

BR, Jarkko
