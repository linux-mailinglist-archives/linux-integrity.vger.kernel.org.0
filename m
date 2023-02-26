Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA2B6A2DED
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Feb 2023 04:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBZDyU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 25 Feb 2023 22:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjBZDyJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Feb 2023 22:54:09 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CF9E04F;
        Sat, 25 Feb 2023 19:53:38 -0800 (PST)
Received: from sparky.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 259D720009;
        Sun, 26 Feb 2023 11:42:46 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1677382968;
        bh=v9u5zE3gBrNPSDJKB7MdaI+zLQsqR2jb7NwkG8O/mzg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=UwFgewjFK0hiJjjABgJy0jHq8wkH9TONFVcmzWZtspVsgldNxRRify0QsJLbr1LlY
         e/Qm7mGED4iE8XCR5BNhDE7ZCraAuMk3vOUUymsZSLNMy/cUd7Nh5wIQml8IRZtnwq
         q95or/0XQPs8BA4ZFHPmr6TaLoSRAorPEBgAwz8xk6AA1ZVz36O/N91pculQEvN6PJ
         cL/ao+JKqEVcuwyVSKCJHi9qYlTWVSg0Md5qwj3ITQ1e705pPmV4FNw9RbDryGdNkC
         gIteRkG/prUDx+WfaEUOQMe7d734jIS+ldhEaM+PBMuG3hnBGAeHn77YHVh6aFh6xo
         JtwGKsYzn5LAw==
Message-ID: <fec5e8eb3803068a11267f386ddda389a1211736.camel@codeconstruct.com.au>
Subject: Re: [External] Re: [BUG] blacklist: Problem blacklisting hash (-13)
 during boot
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Mark Pearson <markpearson@lenovo.com>,
        Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Sun, 26 Feb 2023 11:42:45 +0800
In-Reply-To: <12ceffb8-4e90-4eb5-2110-a0e69b412cea@lenovo.com>
References: <c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de>
         <af0d6881-76c0-f570-0c5b-f664e261c4cf@digikod.net>
         <632d2180-02f8-4a5f-803a-57a6443a60f4@t-8ch.de>
         <12ceffb8-4e90-4eb5-2110-a0e69b412cea@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mark,

> I have flagged this to the FW team (LO-2105) to get their feedback
> and see if we can get it addressed on our platforms.

Any progress from the FW team about this? I have a fresh-out-of-the-box
T14s with this issue, there's 33 duplicated hashes in dbx:

$ mokutil --dbx | grep -E '[[:xdigit:]]{64}' | sort | uniq -cd
      2   106faceacfecfd4e303b74f480a08098e2d0802b936f8ec774ce21f31686689c
      2   174e3a0b5b43c6a607bbd3404f05341e3dcf396267ce94f8b50e2e23a9da920c
      2   1aec84b84b6c65a51220a9be7181965230210d62d6d33c48999c6b295a2b0a06
      2   29c6eb52b43c3aa18b2cd8ed6ea8607cef3cfae1bafe1165755cf2e614844a44
      2   2b99cf26422e92fe365fbf4bc30d27086c9ee14b7a6fff44fb2f6b9001699939
      2   2e70916786a6f773511fa7181fab0f1d70b557c6322ea923b2a8d3b92b51af7d
      2   3fce9b9fdf3ef09d5452b0f95ee481c2b7f06d743a737971558e70136ace3e73
      2   45c7c8ae750acfbb48fc37527d6412dd644daed8913ccd8a24c94d856967df8e
      2   47cc086127e2069a86e03a6bef2cd410f8c55a6d6bdb362168c31b2ce32a5adf
      2   47ff1b63b140b6fc04ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
      3   5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
      2   58fb941aef95a25943b3fb5f2510a0df3fe44c58c95e0ab80487297568ab9771
      2   64575bd912789a2e14ad56f6341f52af6bf80cf94400785975e9f04e2d64d745
      2   71f2906fd222497e54a34662ab2497fcc81020770ff51368e9e3d9bfcbfd6375
      3   80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
      2   82db3bceb4f60843ce9d97c3d187cd9b5941cd3de8100e586f2bda5637575f67
      2   8ad64859f195b5f58dafaa940b6a6167acd67a886e8f469364177221c55945b9
      2   8d8ea289cfe70a1c07ab7365cb28ee51edd33cf2506de888fbadd60ebf80481c
      2   90fbe70e69d633408d3e170c6832dbb2d209e0272527dfb63d49d29572a6f44c
      2   992d359aa7a5f789d268b94c11b9485a6b1ce64362b0edb4441ccc187c39647b
      2   aeebae3151271273ed95aa2e671139ed31a98567303a332298f83709a9d55aa1
      2   c3a99a460da464a057c3586d83cef5f4ae08b7103979ed8932742df0ed530c66
      2   c409bdac4775add8db92aa22b5b718fb8c94a1462c1fe9a416b95d8a3388c2fc
      2   c452ab846073df5ace25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
      2   c5d9d8a186e2c82d09afaa2a6f7f2e73870d3e64f72c4e08ef67796a840f0fbd
      2   c617c1a8b1ee2a811c28b5a81b4c83d7c98b5b0c27281d610207ebe692c2967f
      2   c90f336617b8e7f983975413c997f10b73eb267fd8a10cb9e3bdbfc667abdb8b
      2   d063ec28f67eba53f1642dbf7dff33c6a32add869f6013fe162e2c32f1cbe56d
      2   d626157e1d6a718bc124ab8da27cbb65072ca03a7b6b257dbdcbbd60f65ef3d1
      2   e051b788ecbaeda53046c70e6af6058f95222c046157b8c4c1b9c2cfc65f46e5
      2   f52f83a3fa9cfbd6920f722824dbe4034534d25b8507246b3b957dac6e1bce7a
=20
- and so generating 33 KERN_ERR messages on boot.

Given there's (at least) a few months' worth of GA machines with this
issue, can we suppress the warning?

Cheers,


Jeremy
