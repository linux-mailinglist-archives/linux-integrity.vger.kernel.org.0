Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21561A482
	for <lists+linux-integrity@lfdr.de>; Fri, 10 May 2019 23:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfEJV2k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 May 2019 17:28:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32980 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfEJV2k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 May 2019 17:28:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so6964376edb.0
        for <linux-integrity@vger.kernel.org>; Fri, 10 May 2019 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ULvb6m5Ct7N+U+Hk+TL0VPodYz5yvNtcE2Pdidu8130=;
        b=OpeS/e5yAb8uvpLXYNqA6N1MI8D7JXLjmHyNft0qks+8R/zc45m3XbQH7ZLcDfretb
         NJx/g0yV7jox/sIORLwOrxO1a9CV1jZa4gZ98sX8gwy7R8ojzc6s0LmwQEN7UABbk8mb
         Fxhe8bCtYUg4ePrk9piZU6axZgBrTRfXt2Nca9QBNovg68zQtj8GUi/rd7SCaOGE7XQG
         maBuJVPgPv8M7/MFnTidvVHklN5G7hqvUjLYWauPMuQewufDa3+DR5c2bfu6JIzKNOi0
         rmTdxIt5cPg9YEIjCngJ1xtbJ4MWbtHDYD1wkUYVwYJKhe+0vPHojo8IZxOQPW4XrFjy
         V9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ULvb6m5Ct7N+U+Hk+TL0VPodYz5yvNtcE2Pdidu8130=;
        b=c4mAuJGgwV1GAaODUwmoqVQ/fJafkdK8fUo22cjS7JC2ufK1v3bwMcgbctAGQDq7zM
         OVAqPpEDrFHf8IJNjM6k641JDhBE1D0iQSS23duN0vS3EO8FPxfR6LDgUbcqgawMYCym
         UEs25rvUrCi350DWj4gH2+/FISSDuKbsdAnpQ1/0ymnAr2JWbQ49eMG7L8QBdN9auuHw
         sqfGV/GKom9RSIpAZFZG7yRvF52/OcCLFhFT2xcwe1rTxICjsdz8rFaQcYoY8emkC1bN
         8SLGsPEsgz2SD71atdWAnWcz7W3DkS4tfbE4XOiM3ah8inwrFcxXXae4f+vMLsddCMSm
         5MhQ==
X-Gm-Message-State: APjAAAVkZY3O2txxkg2fM1VgrdRjwznAxM8OFZFkIhSOaknHFT6IOSre
        NDvy08QmH+Tp5XjOJpI6A3t0Ng==
X-Google-Smtp-Source: APXvYqwB8IbdmimHYeSIRTDySy1Eup7HC96peg+2fx8bMgd82d1e5doTbK2hNZI5/C/ZsrOzqlCN9w==
X-Received: by 2002:a50:f5d0:: with SMTP id x16mr13446339edm.287.1557523718509;
        Fri, 10 May 2019 14:28:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:1b:201:ee0a:cce3:df40:3ac5])
        by smtp.gmail.com with ESMTPSA id c6sm1742858edk.81.2019.05.10.14.28.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 14:28:37 -0700 (PDT)
Date:   Fri, 10 May 2019 23:28:31 +0200
From:   Jann Horn <jannh@google.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com
Subject: Re: [PATCH v2 1/3] fs: add ksys_lsetxattr() wrapper
Message-ID: <20190510212831.GD253532@google.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <20190509112420.15671-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509112420.15671-2-roberto.sassu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 09, 2019 at 01:24:18PM +0200, Roberto Sassu wrote:
> Similarly to commit 03450e271a16 ("fs: add ksys_fchmod() and do_fchmodat()
> helpers and ksys_chmod() wrapper; remove in-kernel calls to syscall"), this
> patch introduces the ksys_lsetxattr() helper to avoid in-kernel calls to
> the sys_lsetxattr() syscall.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
[...]
> +int ksys_lsetxattr(const char __user *pathname,
> +		   const char __user *name, const void __user *value,
> +		   size_t size, int flags)
> +{
> +	return path_setxattr(pathname, name, value, size, flags, 0);
> +}

Instead of exposing ksys_lsetxattr(), wouldn't it be cleaner to use
kern_path() and vfs_setxattr(), or something like that? Otherwise you're
adding more code that has to cast between kernel and user pointers.
