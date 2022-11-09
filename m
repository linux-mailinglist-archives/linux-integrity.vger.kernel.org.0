Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48871622151
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 02:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKIBYR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Nov 2022 20:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKIBYO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Nov 2022 20:24:14 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B0460376;
        Tue,  8 Nov 2022 17:24:11 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h21so9696731qtu.2;
        Tue, 08 Nov 2022 17:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3bArshq2eyg3hLMepiT1bgGKeZeMxvntrLUq44wF0Y=;
        b=CTX/cYJBdS03SBZmJa1BZmatkKUgloDzEz81wgxZuFYk7QTdCDZiALT2SFN8kMQZQv
         NP/ogMs+va3hc67H7wov5KOm1QdOvcSMmyOeWEPZmFs0z1EE/hJE4HSWQzeafjKEtfcz
         5GLt6Z0vG6YUelx9DZZnIzyS59PTm+WRpLHJrL5EQlikL2Iy1WdRt3AmonyPKoKGYqYI
         EBmn4cmhZyq1CCNqWTBWnIe/F7l1fDrSegnr68O6OSBG/+BXjT5+Jayz5roUSEKZ3A4z
         4C7AErUdJ9ZPs38hRw+zygss8LAcyj6Jn2IiXOW2hbtBODsywrSP1jXw0IN2rJPEIMD4
         Remg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3bArshq2eyg3hLMepiT1bgGKeZeMxvntrLUq44wF0Y=;
        b=sSYO7n8vn4omFEktwLaw5OwHsx6uzEIpXxphpyVNf3LNz2I2r2QXuBJYvzpJpfcQc3
         nw1BBSKo4eO3PugzBOS0GUKI1jhDan6Nv7RbBIzcaV65cteBjx8vKfOTGYfwGsMbrISr
         fJwKcpWfUNcbBaWTDfgiJFTgkhdRwOvqUAZK/oP3uEsbxdQqKbq1GjZhRr06Yoyacoml
         ImUm+PUH76QN59MCRxDlz2RuvtuwzMC90nfQjlEIR30DeRm6D8anvEvDWCRkr4NCNe+l
         X3CN3AQqMHZf8uAxHWgZ5H1XADUCnQZ2d6XeXxYGl7q/MxtknSlMAoNx5jqwDJ0P1N6+
         MNnQ==
X-Gm-Message-State: ACrzQf0Oh5k8QuZH7OAAIqa2/JVdcBERlBuNE3lgp5eg8hnxNWbY43P7
        3HGURvc6WFCIpZz5HCjpsg8=
X-Google-Smtp-Source: AMsMyM4/pwPWwiLUI5cR0ax3Di1wr+MJtrxOcKP6v6JXvZerf1yzWyN93OY9xiRWwaU/ETpL9UZD3g==
X-Received: by 2002:ac8:48d0:0:b0:3a5:1ed8:4a46 with SMTP id l16-20020ac848d0000000b003a51ed84a46mr41423317qtr.407.1667957051016;
        Tue, 08 Nov 2022 17:24:11 -0800 (PST)
Received: from [192.168.86.38] (c-75-69-97-7.hsd1.nh.comcast.net. [75.69.97.7])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a29c300b006fa4ac86bfbsm10377337qkp.55.2022.11.08.17.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 17:24:10 -0800 (PST)
Message-ID: <faa10c58-268f-ddc8-b86c-02c903e29f8a@gmail.com>
Date:   Tue, 8 Nov 2022 20:24:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>, eric.snowberg@oracle.com
Cc:     davem@davemloft.net, dhowells@redhat.com,
        dmitry.kasatkin@gmail.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nramas@linux.microsoft.com,
        pvorel@suse.cz, roberto.sassu@huawei.com, serge@hallyn.com,
        tiwai@suse.de, zohar@linux.ibm.com, erpalmer@linux.ibm.com
References: <20221104132035.rmavewmeo6ceyjou@Rk>
From:   Elaine Palmer <erpalmerny@gmail.com>
In-Reply-To: <20221104132035.rmavewmeo6ceyjou@Rk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2022/11/04 9:20 AM, Coiby Xu wrote:
> Hi Eric,
>
> I wonder if there is any update on this work? I would be glad to do
> anything that may be helpful including testing a new version of code.
>
Hi Coiby,

Yes, this discussion got stuck when we couldn't agree on one of the
following options:

(A) Filter which keys from MOK (or a management system) are loaded
    onto the .machine keyring. Specifically, load only keys with
    CA+keyCertSign attributes.

(B) Load all keys from MOK (or a management system) onto the
    .machine keyring. Then, subsequently filter those to restrict
    which ones can be loaded onto the .ima keyring specifically.

The objection to (A) was that distros would have to go through
two steps instead of one to load keys. The one-step method of
loading keys was supported by an out-of-tree patch and then by
the addition of the .machine keyring.

The objection to (B) was that, because the .machine keyring is now
linked to the .secondary keyring, it expands the scope of what the
kernel has trusted in the past. The effect is that keys in MOK
have the same broad scope as keys previously restricted to
.builtin and .secondary. It doesn't affect just IMA, but the rest
of the kernel as well.

I would suggest that we can get unstuck by considering:

(C) Defining a systemd (or dracut module) to load keys onto the
    .secondary keyring

(D) Using a configuration option to specify what types of
    .machine keys should be allowed to pass through to the
    .secondary keyring.
   
    The distro could choose (A) by allowing only
    CA+keyCertSign keys.

    The distro could choose (B) by allowing any kind
    of key.

We all seemed to agree that enforcing key usage should be
implemented and that a useful future effort is to add policies
to keys and keyrings, like, "This key can only be used for
verifying kernel modules."

I hope we can come to an agreement so work can proceed and IMA
can be re-enabled.

-Elaine Palmer
