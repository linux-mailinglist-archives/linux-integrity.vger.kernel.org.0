Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06346509FC
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Dec 2022 11:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiLSKVM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Dec 2022 05:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiLSKVG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Dec 2022 05:21:06 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4F82DCD
        for <linux-integrity@vger.kernel.org>; Mon, 19 Dec 2022 02:21:00 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id i188so2245769vsi.8
        for <linux-integrity@vger.kernel.org>; Mon, 19 Dec 2022 02:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUpr7ovRgR/UWEsQ3Fe+jNuGKxRQ+tHrCUEHY6ZYx80=;
        b=ViLxqvOkn3RGBEpW5txZocgCA93ZE6UhUixWNy8ogfZ3gEjE/ReRA2Y/HyBzTrvqb8
         03W2yKHaMZVaU+ulEKthMMzF05UJZyuqH7MExtesTrDpshWbqYOQxPTNt+yPeZmlkIaF
         C/mUfaj7QfollhaNKgriKvK0GebADQp0lqSEwtL++B4t5u8WOkDJ5h/H9Nj5FvuV9x1I
         LTmkyCy1DPVWTqz18Q9P9WzhrFJ8qEydb4JvXkxb3ydIsZj/GmvI7BbJq9aFjC4oPo3z
         hC+bcY/UmDiaZrs+YtdgZq4lxS/pb+usTaZAZhOxrUF2Sw8zUOFh9ui9XCVS/m8BYS15
         xsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUpr7ovRgR/UWEsQ3Fe+jNuGKxRQ+tHrCUEHY6ZYx80=;
        b=p1vveVsGhGusaj6mxr3HldPFglorPsRw95cPrNxCJAjYDTtdBfZrQ9t3shdtgKrZde
         m15Y7IOp3D+rOm3qk8ICw5jFxz3TiDy+opFbjzagG+x7iYtM2LUCXtkCaERB1vGrTI8p
         fiiHFxAUcCkVIFNmVe7z7R6SmWsQGtaCeZ5Eaau285MbhYEfMRdBn0dlqX/5QLcDoewX
         oruWzyBa1iExUzUmpvBIiJ4Aj9+gbvITIyibw0idsz225YqObhw/wLE7bZ7X3wYH3DRq
         BaLd23MoM8MdjuREUlthTa4dPqZ31DSPSB9JnIKui1XVO03Dg1Jp1Lg4PT5zLCEijJzm
         3HiA==
X-Gm-Message-State: ANoB5pkhII0ss3csqG2UCrRx9uGywITLgUL2Pq7XCUrvZ4EBa5EqOFjf
        5RbpTFjIcmy3hrleSIrSJSnRlwMl4Gpr2n012gG8gXapIhacY2r7
X-Google-Smtp-Source: AA0mqf5bGiizSNLJhEAri4uEfJg8DxvByg09JklVd4kphf/joz288XqYAg9mtygwxIc1uda0Rydpy1OvsJQ0of8H9eI=
X-Received: by 2002:a05:6102:5ee:b0:3b1:a1c:3cab with SMTP id
 w14-20020a05610205ee00b003b10a1c3cabmr20675424vsf.46.1671445259661; Mon, 19
 Dec 2022 02:20:59 -0800 (PST)
MIME-Version: 1.0
From:   Sughosh Ganu <sughosh.ganu@linaro.org>
Date:   Mon, 19 Dec 2022 15:50:48 +0530
Message-ID: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
Subject: Question on loading trusted key with keyctl command
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

hi,
I am trying to enable the evm hmac solution on my qemu arm64 virt
platform running Debian. I am using the swtpm 2.0 implementation for
the TPM trusted source. Before I get into trying out the evm hmac
solution on the target system, I wanted to check creating the trusted
and encrypted keys.  Other details on my set up are as follows

Distro - Debian 11
TPM - swtpm
Linux kernel - Linux version 6.1.0-13032, commit 77856d911a8c [1]
keyctl --version
keyctl from keyutils-1.6.1 (Built 2020-02-10)

When trying to follow the steps highlighted in the
Documentation/security/keys/trusted-encrypted.rst, I can generate the
trusted key. However, when I try to load the trusted key using the
command shown in the document, it throws an error. Has there been a
change in the code, or am I missing some step when trying to load the
trusted key?

Steps that I am following (after having created the SRK).

# keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
# keyctl show
Session Keyring
 442944693 --alswrv      0     0  keyring: _ses
 925986946 --alswrv      0 65534   \_ keyring: _uid.0
 401286062 --alswrv      0     0       \_ trusted: kmk
# keyctl pipe 401286062 > kmk.blob
# keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001" @u
add_key: Invalid argument

-sughosh

[1] - I enable trusted and encrypted keys above the said commit
