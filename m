Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6436BC6E
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Apr 2021 02:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhD0AED (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Apr 2021 20:04:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42753 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232295AbhD0AED (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Apr 2021 20:04:03 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A17A45C0181;
        Mon, 26 Apr 2021 20:03:20 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute1.internal (MEProxy); Mon, 26 Apr 2021 20:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/0Nvjt
        qhDxXexWpJ5EuXl0/0v1eHkBPodoAEvwe222o=; b=dzTYfyVNkYtHbQhDtoR88l
        cgZTVAwGXkFV0YmKIVZQG8WNQeCETcRjNg4iGc/lBp3AUawpAa6BITU0WTZcJqHd
        hf3FfEhizc6wQmLiSyBx6ar8NdvKBbTYkzDx0pmk7JjUXofR2vYeBSo68+tGpfgh
        dU/dYpTL+nbicxyaaIzMaTEoQQBszQFauJwbf18K/JgRjs5z7FqBMJ+jT9+OLN32
        oIinmoKgADNkdWNTY43gDQ81myzlT3Wi56+Y6W5V/ahjTfjpOun3uodD0l2TY9d/
        0c7QqmjfDosDAm+HhGLcxmsm8xU1S8GwPEGS5w1/0IZAe18YHpPIRDs6fAR8B/Sg
        ==
X-ME-Sender: <xms:yFSHYPLF7dkB_UrV6c_RxxyhREi5jBawO8sLoYDWQoHKju8YO0BPjg>
    <xme:yFSHYDLQIgk0Ctfe5xIdlSX76e8IAHIymzGoMlOV71P8tBFBPvQwi-l0Wabm0gUT7
    kWCRjHu7zE8_YkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdduledgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevohhl
    ihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheeuveetkeelfffgfeeukeelueethfdvheetfeeftdfftdegtddt
    heeiudefuedunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghrsghu
    mhdrohhrgh
X-ME-Proxy: <xmx:yFSHYHvpV2z-RNI4MpXfhkH2O64mrgyGWU18oEyf0LRjlaQiTl-83Q>
    <xmx:yFSHYIZXekkkptTFBYuHljRrj6nCsA5O6ulAKt3kYhWOjdZjZTv61g>
    <xmx:yFSHYGZshVORK5WAKL9aY-J5py6oThlUU-H7EPCR9RAte7Hf191t_g>
    <xmx:yFSHYPCabN0Ym49Z1eWBYW0PZFqVJzrSoiRGgXeY_GZwH9tWpzFMlw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5C8AF4E0091; Mon, 26 Apr 2021 20:03:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-403-gbc3c488b23-fm-20210419.005-gbc3c488b
Mime-Version: 1.0
Message-Id: <4a4d068b-569c-4ffd-ba32-8656f761a3b5@www.fastmail.com>
In-Reply-To: <20210420183015.861644-2-stefanb@linux.ibm.com>
References: <20210420183015.861644-1-stefanb@linux.ibm.com>
 <20210420183015.861644-2-stefanb@linux.ibm.com>
Date:   Mon, 26 Apr 2021 20:02:59 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Stefan Berger" <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH 1/3] libimaevm: Implement imaevm_create_ima_signature
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On Tue, Apr 20, 2021, at 2:30 PM, Stefan Berger wrote:

> + fd = open(filename, O_RDONLY);

Missing O_CLOEXEC.

> +int imaevm_create_ima_signature(const char *filename, EVP_PKEY *pkey, 

It'd maximize flexibility for the caller to pass a file descriptor, and not a file name.

> +	if (statbuf.st_size > 0) {
> +		addr = mmap(NULL, statbuf.st_size, PROT_READ, MAP_SHARED, fd, 0);
> +		if (addr == MAP_FAILED) {
> +			asprintf(error, "Failed to mmap file: %s", strerror(errno));
> +			goto err_close;
> +		}
> +	}

Tangentially related to this, I think we should consider doing the same optimization here:
https://github.com/ostreedev/ostree/blob/36693f064c63dad550ebcfed33bf9b95806ddef9/src/libotutil/ot-fs-utils.c#L171

Or alternatively, just have the caller provide a (mmap'd or copied-via-read()) buffer?

Though clearly the most flexible is a streaming API.  But eh, I am not really concerned about that level of performance.
