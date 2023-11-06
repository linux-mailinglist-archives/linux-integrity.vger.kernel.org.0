Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0F7E2CE0
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Nov 2023 20:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjKFTc0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Nov 2023 14:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjKFTcW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2023 14:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E408F3
        for <linux-integrity@vger.kernel.org>; Mon,  6 Nov 2023 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699299094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=ASFf3jj0lazzOKnHJ/q3yO4maXPHk8gbLkUqNytOQ6xTG2dufg00/+F0u9inNM9APzRo/5
        SElMhLm5CFMQsfDPQ8k7INcQ8V+fEBBVSyEcVdFRFaXQdt7M+t2/w33HPKIpE2/m62lKFR
        hRlcmYvT0Z+oYrRTbVMwgylrr2Sr7TU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-5cpNd4fkMF27erwpYL49mw-1; Mon, 06 Nov 2023 14:31:33 -0500
X-MC-Unique: 5cpNd4fkMF27erwpYL49mw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-778915a0c73so492256985a.1
        for <linux-integrity@vger.kernel.org>; Mon, 06 Nov 2023 11:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299093; x=1699903893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=cFwk4/Nlb/AK2eTLtCZAbAx83BFOqfMcKxb29MZ0qrjMbeSSa7bi+6IaqqFjRss2n3
         aanBDBHU4QC7ENI9J9Xu0LLRTzUUzxA0d3lCxtABI2SxcV9Lw7HUjbDQ7hf/tFqd5XnD
         MaJxyq+VB5mLlXaGOh8qroW4c+1ABLmsd2CZ5jr6wTEApVNzP1//NGdfPq7kuHLDRU81
         m5dTfIB/KIhISDw/bfi7uV78h4UXfa/w+KlzQfrzgJzRkT0lvmSNipMYdspTayuaJ3aR
         8/ZLKU+8fz7DUAPb0TkoKRYx4lTf40fOfPAyicnF/HZjy2s7AEIEonP/LznmtjF8BnjX
         jWOg==
X-Gm-Message-State: AOJu0YwMPvJmCa73JPTjQVcj0wJMGhOUtNx/YQSjENIhMfmvE7mZ49wZ
        DPBRq0RnnkaaTeWMjxAQY9VOnDPD2ARnayMRTW2KrzrkuySCb8VJpaYU74yJ/Tmv4ErKd56slCF
        v4ddeZxhH9pqnpSUUQ5aIBxDTuSK3
X-Received: by 2002:a05:620a:31a6:b0:773:c4c8:2d58 with SMTP id bi38-20020a05620a31a600b00773c4c82d58mr33054191qkb.59.1699299092999;
        Mon, 06 Nov 2023 11:31:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMC4OZw13o7zojxKDTLQnTVqildfL87qAiPF2IC97OBWWvfcH0eCZKZ8LoCuggfuWN7AoEdg==
X-Received: by 2002:a05:620a:31a6:b0:773:c4c8:2d58 with SMTP id bi38-20020a05620a31a600b00773c4c82d58mr33054171qkb.59.1699299092693;
        Mon, 06 Nov 2023 11:31:32 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id oo12-20020a05620a530c00b007758b25ac3bsm3555862qkn.82.2023.11.06.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:31:32 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:31:30 -0700
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
Subject: Re: [PATCH v3 3/6] tpm: Detach tpm_buf_reset() from tpm_buf_init()
Message-ID: <xp2tdlw2qjg3pbazb3oye7poeh4r5neeqbsvamgiazdl2bouwa@qnxhvt7vzkpb>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-4-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-4-jarkko@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

