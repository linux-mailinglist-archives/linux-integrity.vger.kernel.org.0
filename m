Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2954B7E2CCD
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Nov 2023 20:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjKFT1l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Nov 2023 14:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFT1k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2023 14:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA671BC
        for <linux-integrity@vger.kernel.org>; Mon,  6 Nov 2023 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699298813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/C/WjxiCVsJz9f1oEP2Y4XakhqVX5j64dRCa7+qXYyE=;
        b=hqKzvSPDj2j3nBxuFmkXuNVbKviSYy4lYQJMnseMRcM1yc2kSPAIn/7taFCPe0kOMoVfJp
        s0mNEbD+UR4xk3P/fI8exPD5R1x4k1J5LijLoq/kpYUzmkdpDCbh9yE56ccApraPjMZPqf
        q5OucSFqHKuYcoQoDjyyP43t0lXYK4g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-6QU77QxwO-GvF0GG3te8Og-1; Mon, 06 Nov 2023 14:26:49 -0500
X-MC-Unique: 6QU77QxwO-GvF0GG3te8Og-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-779f645c74cso538314185a.0
        for <linux-integrity@vger.kernel.org>; Mon, 06 Nov 2023 11:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298809; x=1699903609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C/WjxiCVsJz9f1oEP2Y4XakhqVX5j64dRCa7+qXYyE=;
        b=lCEXuUkT1FTvlt9c/AXBlx3YnI6lTKzEIDo9CmFaNyIKH0n/JA2S11Q1c89u60vhbg
         uilTzqvVWbvnVR/vRG34EB5RL3SJqTlYFV37nty3s7SWmLvooi5p5uRnJ2QK9yGu5zqL
         TKhVJZHfbrHuqftr9v8ICGC5ygGtsfzr9erw4aIxbEO8Xs+zB6QV+4nuCAdOpLPUEzox
         7nFO55JuloSD+RZxJVYnH5dMgQZcUSLsdEG1X1CfSGeXJGpBZei0VwD/+9ir4H8G0eW9
         8Rcl+DmWG4/0MZJHl0xAOKrz56mCvlpvwME9ybVi1qFFagf24S5JNnGE9fQmmkJJpORX
         3GcQ==
X-Gm-Message-State: AOJu0Ywng53FPfS3+/mRAAlWXlASOawp3CnRuTgWKWr1B6uVSCZjUlbo
        KjkNNhB0TSOApAlhUKjR2on86YNDpIQB87X56MYrTcaqWGheFvVedlXTlCi/amFu2NaZjnogLRN
        xgDmPLH1G27YNcE2U/llOh/o6uCNq
X-Received: by 2002:a05:620a:444b:b0:778:9542:a765 with SMTP id w11-20020a05620a444b00b007789542a765mr40268960qkp.64.1699298809008;
        Mon, 06 Nov 2023 11:26:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4J4SaJitD2GuvTLmTEH/lixSVaiP4mCjrPIimN2+kmtJXKyqkH9XwjIiR80Gp98vcOrUInw==
X-Received: by 2002:a05:620a:444b:b0:778:9542:a765 with SMTP id w11-20020a05620a444b00b007789542a765mr40268946qkp.64.1699298808800;
        Mon, 06 Nov 2023 11:26:48 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x8-20020ae9f808000000b007756e75b91bsm3554551qkh.78.2023.11.06.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:26:48 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:26:46 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] tpm: Store TPM buffer length
Message-ID: <lifu6orgfo57usei3szyfrmr6ofl37477gji5xh5bwkhftswxg@cjwwa5okjshi>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-3-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-3-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

