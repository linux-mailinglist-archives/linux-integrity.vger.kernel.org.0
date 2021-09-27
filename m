Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94D041A0D4
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Sep 2021 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbhI0U5G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Sep 2021 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbhI0U5E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Sep 2021 16:57:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73964C061604
        for <linux-integrity@vger.kernel.org>; Mon, 27 Sep 2021 13:55:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r23so28826965wra.6
        for <linux-integrity@vger.kernel.org>; Mon, 27 Sep 2021 13:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U6zWwQxcpAE6GCT82qO+mgKANcsaLZPb64cO70Bu80I=;
        b=Wv1EHt+93GUbuo9bJD1sXzeal5WJ6Pf0k9Tztn+pJAa1UYiPqyWFp0KfKVJqQ47iNR
         Tkh9WS13/UTnEkYkdtT5UR1RyOb0MSola0IQRe9gcdZfWem/m0/X/cT+7hl3gB9FM3b9
         yQPiQvONbNOEBiNCsCX6aDD7hJXcuI08t9X9GO+4Hb2fLwMRvyWF8jMIkMaUEWo62ays
         D7XMxcDvkMTDP5/KnF0VGhkvesa+7Zp2RSzF0xIVHjm1I9lI7fZrIjJW7n9vL1bl3hx2
         GFCctUws+PUcBLqOuBURliPEGO4IX4MkQWm6W9ikjAmFc5gs8VjzRM5tVVziPI19RyEa
         YQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U6zWwQxcpAE6GCT82qO+mgKANcsaLZPb64cO70Bu80I=;
        b=3r2LoIK2qbonRKaSjqYFUo6fWOX3aPRDj7v/ATLTAJLhehRpdmlkQiShRQH4AZUMms
         377Hnn1y8ZQATrdEbtegJlhDkF9AFXPM76YTiJiCi1jwPOVFfMTNA9iKETEEBE1yIsCL
         7APk0snL9WPRsaQnpyi5yqBHPcue58IOJvXSKql6KNUGAdzYOVCfoot+GX4MKQ/trAXC
         A4KrlqOp7wdsm38o6Lj5cjiaXwpoewxZpKpCcfTJT7Ln301xKn/HC99Y34avZVPfMqqR
         5o01065B1wT6Z5SVFuglLSpzHcO67IaqtmkOR8NMmedUqRCCa/Vp816Lpz99cvjQq4Pd
         t6Fw==
X-Gm-Message-State: AOAM533Ztu6ZaIK9WdvsMM5j7JEDa1pWr2S7I4g1phyYfanJnzXHgzRo
        qs/dIWhKB/GPJBzJJG7BMSCjsg==
X-Google-Smtp-Source: ABdhPJxlX63/0ctLRQO10ldC1ZakLk0B77JLbmuDyBqXiyolom3ixcRU9RcL2Ktv7BKSKEDZ6w4/Mw==
X-Received: by 2002:adf:b748:: with SMTP id n8mr2231688wre.133.1632776125063;
        Mon, 27 Sep 2021 13:55:25 -0700 (PDT)
Received: from localhost ([2a00:e67:5c9:a:6d7b:fc0:e9e9:7254])
        by smtp.gmail.com with ESMTPSA id l18sm1268642wrp.56.2021.09.27.13.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:55:24 -0700 (PDT)
Date:   Mon, 27 Sep 2021 22:55:21 +0200
From:   Andreas Rammhold <andreas@rammhold.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Andreas Rammhold <andreas@rammhold.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: trusted: Fix trusted key backends when building
 as module
Message-ID: <20210927205521.7c4psu4vz5eoyfnf@wrt>
References: <20210730012822.3460913-1-andreas@rammhold.de>
 <0d42a11a-0117-49a9-d2c9-bc6cc405235d@pengutronix.de>
 <20210927085104.vq42feghtaqiv6ni@wrt>
 <856359f263575f01d0ce2fcf8f042321f750b38c.camel@linux.ibm.com>
 <20210927200835.wvazk73cek3t5tkf@wrt>
 <2ad2c536367028ef6d9300745586a123cb13d9f1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ad2c536367028ef6d9300745586a123cb13d9f1.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 16:33 27.09.21, Mimi Zohar wrote:
> On Mon, 2021-09-27 at 22:08 +0200, Andreas Rammhold wrote:
> > On 07:27 27.09.21, Mimi Zohar wrote:
> > > On Mon, 2021-09-27 at 10:51 +0200, Andreas Rammhold wrote:
> > > > On 09:47 13.09.21, Ahmad Fatoum wrote:
> > > > > Dear trusted key maintainers,
> > > > > 
> > > > > On 30.07.21 03:28, Andreas Rammhold wrote:
> > > > > > Before this commit the kernel could end up with no trusted key sources
> > > > > > even though both of the currently supported backends (TPM and TEE) were
> > > > > > compiled as modules. This manifested in the trusted key type not being
> > > > > > registered at all.
> > > > > > 
> > > > > > When checking if a CONFIG_… preprocessor variable is defined we only
> > > > > > test for the builtin (=y) case and not the module (=m) case. By using
> > > > > > the IS_REACHABLE() macro we do test for both cases.
> > > > > > 
> > > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > > > > Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> > > > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > Does anyone intend to pick this up?
> > > > 
> > > > Did this end up in any tree by now? I am wondering if I should resend
> > > > the patch instead. Perhaps it was just overlooked?
> > > 
> > > For EVM environments only using trusted and encrypted keys, not file
> > > signatures, the trusted key is needed to decrypt the "master" key in
> > > order to verify kernel modules.
> > 
> > So what you are saying is that right now (before this patch & after this
> > patch) you could compile a kernel that wouldn't be able to load any
> > modules when the trusted keychain part is built as module?
> 
> Before this patch, trusted and encrypted keys are builtin, so verifying
> kernel modules with security.evm containing an EVM hmac would succeed. 
> Afterwards it would fail, as there's a dependency on the trusted key to
> verify the integrity of the trusted key module.

But building with =m was a valid configuration which is the original
reason for me submitting the patch. So perhaps this should not be
allowed to be a module then?

