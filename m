Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCF1FBA38
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbgFPQJk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 12:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732840AbgFPQJd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 12:09:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41759C0613EF
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 09:09:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x207so9725152pfc.5
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qr6LU5AJyvXIew1juXMAoqiI4cF7kmvmZdA39adClnc=;
        b=Rkw9rZaVLXXtIQ0m20+mYgJQ4gcuayp8YvWp0pVNnyS2Ud5bvdUdx69IRXMW08dI+y
         pzV/H7bWfkwsJ9crKNCDPM1q0WUffbNtBokPP+PZDWzzEdUIZWHq9M86Wqe0z1bOibJL
         0kj7zDc/gs1pT2s4SL4bLi137RE65s/ZSVNpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qr6LU5AJyvXIew1juXMAoqiI4cF7kmvmZdA39adClnc=;
        b=OBmtzKDCw9Om0yW4H4AF5DiwQqkBAaWsf68keawsIl8jKgJfDuaH2q1VWKVht6u5Wu
         zBNdD74KdolVoTkRx7ELAJVPAMMWROjR3FNXTAWlHA+HCyFao6Zd0N0gk2+HWoC7i02c
         qE6cv65HYWHFe1ZRtF008Z/Greeq3YE2xmammge4FUPk4SaKpe4cJ8BH9TFD+iFNR/G0
         V1TY3X0PDQ/V+QD3uIdoGSOfHg7rkCU39XsDXZOpAwzPqiUypd41mTuEbA3b1KMDbokQ
         6LmpD324Xtr3TKQ5OaXPktaEd06OvFbLwIIPZ4HSNq89Z1TOQswoeTu9bG6vu6G+TLxz
         hwXA==
X-Gm-Message-State: AOAM530xE8Q6vElhEw35XM9UAOpxRHSuWpd7FGdTk403r8Z6XMdb5isn
        M7Kscy1N8wf+iPMW49cQtyDM8A==
X-Google-Smtp-Source: ABdhPJw0IGP4wrEgB7iuDlwGXE4MMae76XZ2NoGZ/467ZGcMrf6sY2DenPwGzgjt24xH+kDh+E9WqA==
X-Received: by 2002:a62:9242:: with SMTP id o63mr2821188pfd.310.1592323771469;
        Tue, 16 Jun 2020 09:09:31 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm14999992pgs.29.2020.06.16.09.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 09:09:30 -0700 (PDT)
Subject: Re: [PATCH v9 1/8] fs: introduce kernel_pread_file* support
To:     Christoph Hellwig <hch@infradead.org>
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
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200615194151.7011-1-scott.branden@broadcom.com>
 <20200615194151.7011-2-scott.branden@broadcom.com>
 <20200616073423.GC30385@infradead.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b89a3f0f-51b9-7705-3a23-26196ae7716e@broadcom.com>
Date:   Tue, 16 Jun 2020 09:09:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616073423.GC30385@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Christoph,

On 2020-06-16 12:34 a.m., Christoph Hellwig wrote:
> Seriously, no more additions to fs.h for this interface please.  As
> requested before as the very first thing move it out of this header
> used by just about every file in the kernel.  That is in addition
> to all the other issues with the interface.
I can add such to the start of this patch series. I'm guessing from:
#define __kernel_read_file_id(id) \
to
extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
                     enum kernel_read_file_id);


