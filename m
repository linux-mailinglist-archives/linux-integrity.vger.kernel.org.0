Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C9321646D
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 05:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGGDIi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 23:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgGGDIh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 23:08:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22CDC061755
        for <linux-integrity@vger.kernel.org>; Mon,  6 Jul 2020 20:08:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so16139627plo.7
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jul 2020 20:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mAgioibrvE891f5K7HmCJlPOrtHJXNuC1DkC4uszNXM=;
        b=gP+Wl4DJKDJ3UySQvm6ehWCx/RKB143fnyHUuQ0t9BRhhXM335BMaeWAeNXiPHFS+A
         yuJXG+rXHT/me7lsV8JRFhJGr0PHF+YCM9CfQH6E2adRJBk43IvCMRwvvBVl3/3Ixm3I
         fq54xhOeSkABkDAJr2DPslruFRUcT0nLWUjG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mAgioibrvE891f5K7HmCJlPOrtHJXNuC1DkC4uszNXM=;
        b=NMl6Kz3cBqpAieHyyksdav7mywJ2GhozXO7xebQ87cF90fbWcECfg+0UOJcqE2d/Hd
         /DSdWE82mAIVkjXKUR86R9fvK+aJhxDXuspogeEmrvxO9cSdGeVZrDrRQR+ccoZUmqDx
         esBerobDrQDdvkKdhVcG33+0SUedyHJatWU7ubz2C1xA4ug4JQRUFfLQOVRad/373jJ+
         OM8vO0MuZC4s4LVnP2WVjXCxSS0VNToM+31GmdRoh/uD/iskW1vStZsioF2809ouVwVC
         SmS8/uvY0IsKWREq0WiOUQukT6G3vfyoB0BUipBGGFIKSQLjplOyJN8M+J3IHICS25Yp
         Bo0w==
X-Gm-Message-State: AOAM532oz4N7DLsnmXQ7P8Ugejv+Pq+oqhvbBfvpeOSUXgf5Y2C73JHU
        Ad8xXUmd1l1w3wxxdsyouLqgQQ==
X-Google-Smtp-Source: ABdhPJy83Oe1nEfdDuQGPzOU8w+tiZ5G3NUxNgvI9H4y2E5D1RYyMkaPmU7mTa1I6i1BJx5hBV9wHA==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr45161895plr.132.1594091317238;
        Mon, 06 Jul 2020 20:08:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14sm20750527pgj.62.2020.07.06.20.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 20:08:36 -0700 (PDT)
Date:   Mon, 6 Jul 2020 20:08:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 9/9] ima: add FIRMWARE_PARTIAL_READ support
Message-ID: <202007061950.F6B3D9E6A@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-10-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706232309.12010-10-scott.branden@broadcom.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 06, 2020 at 04:23:09PM -0700, Scott Branden wrote:
> Add FIRMWARE_PARTIAL_READ support for integrity
> measurement on partial reads of firmware files.

Hi,

Several versions ago I'd suggested that the LSM infrastructure handle
the "full read" semantics so that individual LSMs don't need to each
duplicate the same efforts. As it happens, only IMA is impacted (SELinux
ignores everything except modules, and LoadPin only cares about origin
not contents).

Next is the problem that enum kernel_read_file_id is an object
TYPE enum, not a HOW enum. (And it seems I missed the addition of
READING_FIRMWARE_PREALLOC_BUFFER, which may share a similar problem.)
That it's a partial read doesn't change _what_ you're reading: that's an
internal API detail. What happens when I attempt to do a partial read of
a kexec image? I'll use kernel_pread_file() and pass READING_KEXEC_IMAGE,
but the LSMs will have no idea it's a partial read.

Finally, what keeps the contents of the file from changing between the
first call (which IMA will read the entire file for) and the next reads
which will bypass IMA? I'd suggested that the open file must have writes
disabled on it (as execve() does).

So, please redesign this:
- do not add an enum
- make the file unwritable for the life of having the handle open
- make the "full read" happen as part of the first partial read so the
  LSMs don't have to reimplement everything

-Kees

-- 
Kees Cook
