Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC3F67DB
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Nov 2019 08:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfKJH0R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Nov 2019 02:26:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36155 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbfKJH0R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Nov 2019 02:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573370776;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkMhB0wE6t3nkAH0JSMv/COaSrrNN/Kr0CPzL2/Lqa4=;
        b=eQAroHuKHUqXB93Rqr2GiBk6p0IiJ/+wCVLYh9GiJ9VbvMrItUuEMKxc2GL71XaDNgvfMJ
        Hz8sSxm4WoCNStaB8bz5Msdsv9anp6DTP9+568eOL7YHJC2axtqgabgvVrtMKcP+5VAWmA
        ugvmTp7ErJYG6HjCGcTTb7ykDJ13jN0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-BrkHPbZbO8G65m3roEj0IQ-1; Sun, 10 Nov 2019 02:26:15 -0500
Received: by mail-yb1-f199.google.com with SMTP id z1so9301289ybn.16
        for <linux-integrity@vger.kernel.org>; Sat, 09 Nov 2019 23:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=YkMhB0wE6t3nkAH0JSMv/COaSrrNN/Kr0CPzL2/Lqa4=;
        b=HYE9TF/r5xTkFBLjEU4BYskhy1C0ptjqmWk2IGyesvTTFjFnUL3ZogstN9gTVBnZ73
         yiTN7Huo7m1+q+JcWWde7fEl9oN9ywZwLNK8kIMJrgpkWYk1IlP+DQGFMZ5TpHg2RTUs
         MPD97hRuHNvWV9rF+so1Yf/XrfmdBzGg9TgwA1igh1AYErtqCndOb83Z119QPq1tiv0h
         AzhsvOpblm5SOKbPxDhku1H2T0UDgPLOmPH6z+HDIKBvRrLa76Z4I64ro9ySdoLIfLd7
         wuwUjbqzsN2ONRsBmzvLY+6T13v+g1XgbLLhCinFYLJMG78HzMi//+mT+Rh1/P4ObuaA
         mIog==
X-Gm-Message-State: APjAAAVGdI5FoHPh13C+rQb/smKE5HlCYR4estO+FHoIxom/sCEpsqKy
        CAkB3ZItbjkqkYSiUeuasNavU5M7P+0ytn4vPpPhbofK6RQNr4A2fxvKzvkNG7U9bVqscuDd71s
        JsGMZuz75WNMe4KDAW3xQpZVogOak
X-Received: by 2002:a25:ca17:: with SMTP id a23mr16289907ybg.385.1573370774510;
        Sat, 09 Nov 2019 23:26:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyn8U76vTyiUtMFvG11E65EEDEs3Mg26aIC27ez7gXsTP4qa06IjAr5gHBn2Vzj8ofAYu1Zmg==
X-Received: by 2002:a25:ca17:: with SMTP id a23mr16289898ybg.385.1573370774239;
        Sat, 09 Nov 2019 23:26:14 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id b199sm12299949ywh.23.2019.11.09.23.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 23:26:13 -0800 (PST)
Date:   Sun, 10 Nov 2019 00:26:11 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Christian Bundy <christianbundy@fraction.io>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: PROBLEM: TPM bug causes suspend to turn off device
Message-ID: <20191110072611.2k6tjt4geiq2rqol@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <a60dadce-3650-44ce-8785-2f737ab9b993@www.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <a60dadce-3650-44ce-8785-2f737ab9b993@www.fastmail.com>
X-MC-Unique: BrkHPbZbO8G65m3roEj0IQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko, should there be tpm_chip_start/tpm_chip_stop calls around
the tpm1_getcap calls in tpm1_get_timeouts?

