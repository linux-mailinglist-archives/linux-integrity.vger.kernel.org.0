Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E072977FB73
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Aug 2023 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353451AbjHQQFN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Aug 2023 12:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347318AbjHQQEp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Aug 2023 12:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D5230F3
        for <linux-integrity@vger.kernel.org>; Thu, 17 Aug 2023 09:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEDF06733E
        for <linux-integrity@vger.kernel.org>; Thu, 17 Aug 2023 16:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07F1C433C8;
        Thu, 17 Aug 2023 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692288283;
        bh=299g5Zt/1/lNaa9aQxVq3umnmTpMOmtsmEfkcntNnSA=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=ILagd3/A5S6McI07wpodUZIi/7rkZeIweymooYRvdYR54Ea11/MshQgwTiJqDVGF4
         OaccwnpQAF3Mk5y6qWreKRlUgk3ZmYj3HgYYPm99tvJRRs2J0lmM74o3pTKIJSZi/y
         gxYlM41gFJKFqhVXb4cqcwWHezIY4ftPn/PqGXSyyEG8qoHisqpUds3VF1jkSvf2zx
         bWGmVyXF5g0thFVfS2mzAglt+6JVG3mexJzGJz+R6xiKrcfAsd4QKvRuwj8J7c2VKf
         h5a0k6eyr4cXvX5hikxjPzu8EvdyzEYHg+Ju/HsTHRyOZ+vg9yKDiwSxoOsN8Ocfm3
         dHLumM8NRCnRw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 17 Aug 2023 16:04:40 +0000
Message-Id: <CUUY4NO1I9DA.1S0KWKJVHQ8K5@seitikki>
Subject: Re: Linux IMA documentation
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Ken Goldman" <kgold@linux.ibm.com>,
        "Linux Integrity" <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <a5ed5a0f-5692-426e-d058-983cf4d9cccb@linux.ibm.com>
In-Reply-To: <a5ed5a0f-5692-426e-d058-983cf4d9cccb@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Aug 16, 2023 at 9:42 PM UTC, Ken Goldman wrote:
> Is this the right place to announce this?  If not, let me know.
>
> https://ima-doc.readthedocs.io/en/latest/index.html
>
> This is a first pass at IMA documentation.  It's targeted at users, not=
=20
> kernel developers.
>
> Some areas are clearly incomplete, but I don't think there is anything=20
> incorrect.
>
> Suggestions, contributions, corrections are all welcome.
>
> The source is at https://github.com/IBM/ima-doc

Looks useful for non-IMA kernel developers too IMHO, thanks for doing
this.

BR, Jarkko
