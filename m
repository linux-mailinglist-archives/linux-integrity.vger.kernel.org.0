Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324FA43B20D
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhJZMO4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Oct 2021 08:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbhJZMO4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Oct 2021 08:14:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF96C061745
        for <linux-integrity@vger.kernel.org>; Tue, 26 Oct 2021 05:12:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 82-20020a1c0055000000b0032ccc3ad5c1so934577wma.2
        for <linux-integrity@vger.kernel.org>; Tue, 26 Oct 2021 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=yCf+F0GmHnDwhpZJvN1skt34FOjo0gmVkyRLRwMgACY=;
        b=q5BK/RPO1hK3ir+WBN10yfLed0PVt83YCUKlewvVLGQx0gN8AjWH/xb2xYQPfo9rS8
         v1h7uEamUVMOA0KWGz8Lc+pvYsiGZkkU8VCeS4v9fVxADU+arzfBw+fSqmnYfc0p5GDn
         4jqKvfUjk45uXXHdfpm/KMbC0bQg5GGwfq7sw+eSus7LXOcJaxONF25VTtPcjsZXMaDf
         EpqS/BLeCL01ofTHEKmUsYOHvge9qZO6Bcjdxppn1NTWmew/bqQlRMPl/PcNdvCKted7
         dev6yfpmFkbS1l49Y1yVkjlravEBrIvXSsNGqpJI5/3LUPdm14aFfUfA0x1l4con397t
         XbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=yCf+F0GmHnDwhpZJvN1skt34FOjo0gmVkyRLRwMgACY=;
        b=18No5FI/xqQdJWvXboie7ErOa46DYvPzeKQAgliGY4FtOi5+T+JJiBK1j7t0wbxun8
         TfCtErBn83PBoicmSOp0viof8hZB4svLuh9IP2gGQxvPlsLcWCT3rJy9KuMXGDzxDCbx
         Zk8BqqRgIax6Um52dKn0k3wXdpF0OhMHfHlm7a5MUurAe011PdgATsbAYx7Wji8WhdWR
         j/kRGl+M+ddx4jPX5Noc59Xb29ZWe+xyEG0PB2bilWxCk1sHzzJDwd+Nx1JtKuEJ1Usa
         fgZ7bOftewU0WHzcJuiJUC7xg9DkXX5nNfjCedy+/57qR8Bj6jLnThEeeAgEf+GKMz+d
         8hOQ==
X-Gm-Message-State: AOAM53279lbX+hi/cI5p039v3h73Msp332GPlGniaAmorfZJrPmsPoTs
        vBz9Rb1c/o3frCBcLYI6D3epGy5EEjk=
X-Google-Smtp-Source: ABdhPJynSB391PtlUtgnLyPxl5vZSIq/8PWiVXX/RaFUJTO2+gen5q0ePxb0P9CJCa4U7JrxEwFbug==
X-Received: by 2002:a7b:c926:: with SMTP id h6mr14225541wml.41.1635250350860;
        Tue, 26 Oct 2021 05:12:30 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id h14sm458947wmq.34.2021.10.26.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 05:12:30 -0700 (PDT)
Date:   Tue, 26 Oct 2021 14:12:16 +0200
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH ima-evm-utils 1/2] switch to using crun for podman
Message-ID: <YXfwoOEZZKKII6s9@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20211026024929.535519-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026024929.535519-1-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Fix for:

> "container_linux.go:367: starting container process caused: error
> adding seccomp filter rule for syscall bdflush: permission denied":
> OCI permission denied"

I was surprised crun is updated but runc not, but LGTM.
It'd be nice if somebody test it with public travis (I no longer have access).

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

IMHO from a long term perspective it'd be nice to create GitHub Actions profile
(but that's not related to this patchset).

Kind regards,
Petr
