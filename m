Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627D86197A6
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 14:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiKDNWC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiKDNWB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 09:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9C02A5
        for <linux-integrity@vger.kernel.org>; Fri,  4 Nov 2022 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667568058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=4z+uaTyHS1euo8ITS5ujuXPAETlqQ178964oXSUna1g=;
        b=hGd8pylCeh0mGbZZWCiLN4JbsVkueKhNa7k1o67opB0XAJ9C6s3vZDzLRojj3ufxKf7UXE
        lW3kevGaxfDKSPzUr8tSsRhx30Ushk/hYVs7NGLEAEKnsYpQ6g6CLGUSuNA4dbjwwrYUfT
        P1dgEvzYsPHj/KohGztIxfqr2fuh2+k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-0HVYtToqMZiZhX4QVIW_CQ-1; Fri, 04 Nov 2022 09:20:57 -0400
X-MC-Unique: 0HVYtToqMZiZhX4QVIW_CQ-1
Received: by mail-pg1-f199.google.com with SMTP id u63-20020a638542000000b004701a0aa835so1853497pgd.15
        for <linux-integrity@vger.kernel.org>; Fri, 04 Nov 2022 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z+uaTyHS1euo8ITS5ujuXPAETlqQ178964oXSUna1g=;
        b=quUdZpup0Frw+CD+xBGzjcOIsxJWGM+FBNess3mdLc5qpQkUQtpiw8egmZcWwhn8yN
         36VwIcjdJTNCcLlcgLMqhjZNk1vKa8RjuGFdOD1tGoGJZidSsW4lgTWbsqHkf3OvymAa
         c0C0gxlKHJ/NVifjWe5oIiDTkzZhERU5IBT/Yspih14gdeTaPR3es8dWDNf6iwQNONrw
         HJOQYrWtV0TwJtNbF4iFSXGv/GO5o0hunNG9/O0GIYtcYkBDsvoA8HicGfwz2z+ziUFu
         /seougYcnWqiUGK6OIMFufkqdCqLVBXZ+6n6bK6qhZP5UpSUS/qfDhYhkmOJqklhgAXJ
         B8CQ==
X-Gm-Message-State: ACrzQf1+prYIiAALWZq7xKHIQujIb6WeaItKKcUIcK/1u3gqjwL5u4c5
        oDP/ZTguGL9zm7P1ySGwRdH0XjRO39FdLAqjYBhLr7YzqW+nvxRFbTTEBQdB0CeDETreaX9i3lv
        KkUBjCMHkVdX4n0h/tNC0uX88OyeE
X-Received: by 2002:a17:902:e8d4:b0:177:e4c7:e8b7 with SMTP id v20-20020a170902e8d400b00177e4c7e8b7mr329600plg.118.1667568056599;
        Fri, 04 Nov 2022 06:20:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6XbTeqtZliMwzZ7MGO3ejsjE4fdEnYbMsIkDBmckaWvRU+DhCnC80HUipTcPjnE/pSnZOacw==
X-Received: by 2002:a17:902:e8d4:b0:177:e4c7:e8b7 with SMTP id v20-20020a170902e8d400b00177e4c7e8b7mr329594plg.118.1667568056353;
        Fri, 04 Nov 2022 06:20:56 -0700 (PDT)
Received: from localhost ([240e:479:210:84fd:b8ac:1631:3300:5ef])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001780e4e6b65sm2597596plb.114.2022.11.04.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:20:55 -0700 (PDT)
Date:   Fri, 4 Nov 2022 21:20:35 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     eric.snowberg@oracle.com
Cc:     davem@davemloft.net, dhowells@redhat.com,
        dmitry.kasatkin@gmail.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nramas@linux.microsoft.com,
        pvorel@suse.cz, roberto.sassu@huawei.com, serge@hallyn.com,
        tiwai@suse.de, zohar@linux.ibm.com
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
Message-ID: <20221104132035.rmavewmeo6ceyjou@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

I wonder if there is any update on this work? I would be glad to do
anything that may be helpful including testing a new version of code.

-- 
Best regards,
Coiby

