Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC3791F1D
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Sep 2023 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbjIDVwO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Sep 2023 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIDVwO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Sep 2023 17:52:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5FB1B7
        for <linux-integrity@vger.kernel.org>; Mon,  4 Sep 2023 14:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDE02B80E4F
        for <linux-integrity@vger.kernel.org>; Mon,  4 Sep 2023 21:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DDBC433C8;
        Mon,  4 Sep 2023 21:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693864328;
        bh=tPzaMPYHGpz3yJX6A5YPoCiVV8Une6sibdwbdjNl2Lw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=oh4LoCjuFyyRiXRvmvnH61kXUwWBHHIP9As4QM5iZnCQlWOPx2kV7I7X211ogtbGv
         MW/wql9QasrhRTy+LZQlKnTDl6/sk/49KThxfy90uAt6mWB0Kjv5XNhJtUT03Ju2dA
         VbrGwc65ra0HC1dglgvUF0yvDhebt3diOHuy6XJ5rgwuO+R+jHOBG9+yv7vQ6z52CO
         nq9XuBma3ETdOBMVyeKuz/GuLd9F8uy7kfr1MwYwz4wA9focuIFeG8tc91h8jaV7Id
         iag40L5Xgu2SLMaXMgxsOafmnh1ZfLBboVNJGnDgya9R5hQamFSJXD1Lmd5hHPBKeU
         7EXl5jJvf1V7Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 05 Sep 2023 00:52:05 +0300
Message-Id: <CVAGSGSJ0NC2.1OQUGKH4ZR0ZB@suppilovahvero>
Cc:     "Jonathan Corbet" <corbet@lwn.net>
Subject: Re: Linux IMA documentation
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Ken Goldman" <kgold@linux.ibm.com>,
        "Linux Integrity" <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <a5ed5a0f-5692-426e-d058-983cf4d9cccb@linux.ibm.com>
 <CUUY4NO1I9DA.1S0KWKJVHQ8K5@seitikki>
 <6ea76738-f587-087d-60ea-ed03adedab62@linux.ibm.com>
In-Reply-To: <6ea76738-f587-087d-60ea-ed03adedab62@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Sep 1, 2023 at 12:46 AM EEST, Ken Goldman wrote:
> Thank you.
>
> Do you know the process for getting this accepted into the kernel=20
> documentation.

The bulk of the work would be to convert it ReStructured Text and
follow the guidelines in https://docs.kernel.org/doc-guide/index.html

You should also CC the documentation patches to:

* Jonathan Corbet <corbet@lwn.net> (maintainer of the documentation)
* linux-doc@vger.kernel.org
=20
Perhaps Mimi could help out formalizing this together so I suggest to
work with her. I'm also happy to review the documentation once the
patches are out.

BR, Jarkko

