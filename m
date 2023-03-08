Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F816B0557
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Mar 2023 12:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjCHLFI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Mar 2023 06:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjCHLEk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Mar 2023 06:04:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D31F98869
        for <linux-integrity@vger.kernel.org>; Wed,  8 Mar 2023 03:03:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec29so33263904edb.6
        for <linux-integrity@vger.kernel.org>; Wed, 08 Mar 2023 03:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678273437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mOeVIjm8xAMi1XdiTZIXvjNCduRkLKc7AUq9KH5xfM=;
        b=iAx8gn/CiR1bBZDJ6o8a1ljzFGvp8YzI2fVG2BsIA7s7BDe+pizvRqtU9sz2Gd8JSu
         g85rYIghkuxknjrQyKvOgZopVJiMFsL+TqjWhDVYEl9dejVBaPksboBOb6MliPvsLK8i
         zca9g8lyM8r1QiH3FlrGH7captEnW7SaHw8N28jJSN/2h1+Ndl+0GFQQsMiw+vOjOqHi
         xW340FhEZGlOhqKDPyeHH0i/+1asGoelt5aolUVU6L9hLRbJq+n9GC8Jx15D5j0gdD1k
         +i7N57OLo3kTSTgw7MEaF4dSrNEzOC3C96XeILtqxP4s2X1EQYdSGoeIPEU28zpj21y1
         95UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mOeVIjm8xAMi1XdiTZIXvjNCduRkLKc7AUq9KH5xfM=;
        b=usxlfXWbolEeaja/UUY7uz3bFYMqJp0rKq5h4Ws9lZZcVo/TCQRKTeLEAQRd0FjWu7
         UKLYsiqr6/YUIqWHi13fpJyuqLCXeqF3UVtIezrIEzj2sJ/qVlo34Cg44oSuPPiIyurg
         1HjQvTakachvcddCdZn4WuCL3EPlxHYtb9JhYCmg0tKT+l5v8LvRiiXZ0e119fhSQDuj
         pX+BxnuYVVfBUoF99A7ocv13cAoOWiqm/IV8EpGpFeX6dCuhUZySEqYS1T6y6IVsB5aA
         F4rvweHrusBTrTHRj8jbC/aLgM/D8iMh+AAazt4NxDptcAAkEIxoc740tz+mtJnXyTku
         WsZA==
X-Gm-Message-State: AO0yUKXvaAfQ9Exkl5aEQHKaHoTY6GxGgycXr0dpm8eQDExKrBWyTy+R
        TN+J+Vqg1KjKQOQfL9J6s3hogw==
X-Google-Smtp-Source: AK7set+uYd9BWN+DxCTsFT3RC2Npkxt1wr2xAp2qBurGjWBjqeX355SU3BlD4wSUfJ0rgZioGEugQQ==
X-Received: by 2002:aa7:c0da:0:b0:4c0:9bd7:54cc with SMTP id j26-20020aa7c0da000000b004c09bd754ccmr13681933edp.11.1678273436865;
        Wed, 08 Mar 2023 03:03:56 -0800 (PST)
Received: from google.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id d6-20020a1709064c4600b008eb5b085075sm7233492ejw.122.2023.03.08.03.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 03:03:56 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:03:51 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] bpf: Fix IMA test
Message-ID: <ZAhrl0rK9Yume1Ed@google.com>
References: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ha! I was literally in the midst of sending through a patch for
this. Thanks for also taking a look and beating me to it!

This LGTM, feel free to add:

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

On Wed, Mar 08, 2023 at 11:37:13AM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED
> flag is set") caused bpf_ima_inode_hash() to refuse to give non-fresh
> digests. IMA test #3 assumed the old behavior, that bpf_ima_inode_hash()
> still returned also non-fresh digests.
> 
> Correct the test by accepting both cases. If the samples returned are 1,
> assume that the commit above is applied and that the returned digest is
> fresh. If the samples returned are 2, assume that the commit above is not
> applied, and check both the non-fresh and fresh digest.
> 
> Fixes: 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED flag is set")
> Reported by: David Vernet <void@manifault.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../selftests/bpf/prog_tests/test_ima.c       | 29 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> index b13feceb38f..810b14981c2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> @@ -70,7 +70,7 @@ void test_test_ima(void)
>  	u64 bin_true_sample;
>  	char cmd[256];
>  
> -	int err, duration = 0;
> +	int err, duration = 0, fresh_digest_idx = 0;
>  	struct ima *skel = NULL;
>  
>  	skel = ima__open_and_load();
> @@ -129,7 +129,15 @@ void test_test_ima(void)
>  	/*
>  	 * Test #3
>  	 * - Goal: confirm that bpf_ima_inode_hash() returns a non-fresh digest
> -	 * - Expected result: 2 samples (/bin/true: non-fresh, fresh)
> +	 * - Expected result:
> +	 *   1 sample (/bin/true: fresh) if commit 62622dab0a28 applied
> +	 *   2 samples (/bin/true: non-fresh, fresh) if commit 62622dab0a28 is
> +	 *     not applied
> +	 *
> +	 * If commit 62622dab0a28 ("ima: return IMA digest value only when
> +	 * IMA_COLLECTED flag is set") is applied, bpf_ima_inode_hash() refuses
> +	 * to give a non-fresh digest, hence the correct result is 1 instead of
> +	 * 2.
>  	 */
>  	test_init(skel->bss);
>  
> @@ -144,13 +152,18 @@ void test_test_ima(void)
>  		goto close_clean;
>  
>  	err = ring_buffer__consume(ringbuf);
> -	ASSERT_EQ(err, 2, "num_samples_or_err");
> -	ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> -	ASSERT_NEQ(ima_hash_from_bpf[1], 0, "ima_hash");
> -	ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample, "sample_equal_or_err");
> +	ASSERT_GE(err, 1, "num_samples_or_err");
> +	if (err == 2) {
> +		ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> +		ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample,
> +			  "sample_equal_or_err");
> +		fresh_digest_idx = 1;
> +	}
> +
> +	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], 0, "ima_hash");
>  	/* IMA refreshed the digest. */
> -	ASSERT_NEQ(ima_hash_from_bpf[1], bin_true_sample,
> -		   "sample_different_or_err");
> +	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], bin_true_sample,
> +		   "sample_equal_or_err");
>  
>  	/*
>  	 * Test #4
> -- 
> 2.25.1
> 
/M
