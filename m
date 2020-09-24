Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066622779E2
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Sep 2020 22:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIXUFp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Sep 2020 16:05:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36118 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUFo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Sep 2020 16:05:44 -0400
Received: from [192.168.1.12] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9908420B7179
        for <linux-integrity@vger.kernel.org>; Thu, 24 Sep 2020 13:05:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9908420B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600977944;
        bh=qwLx8+xwi0w/BPw+ipsDeuUARo6Y+R7wE+Ovd2CZy48=;
        h=Subject:References:To:From:Date:In-Reply-To:From;
        b=M13t8UqfDVkx/lOUGC0vQtIVyUHDhL8PKCAFzqhcZkjT9OHFe6lKMacMdRd+6U8VF
         XckNOxrwKm5DV37KYo3Z7+q5L6NfywiTQ/HQOiq8SkrCaqh0ovE9q4KW8RG41yT0fq
         PelLj59+OnCedi5Tfqsi1Zw0T+09IX7P8EgZ2eTs=
Subject: Fwd: How to extract linux kernel version information from a kernel
 image?
References: <b8e9ee52-c0fd-a6cf-3054-4220636a60e9@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
X-Forwarded-Message-Id: <b8e9ee52-c0fd-a6cf-3054-4220636a60e9@linux.microsoft.com>
Message-ID: <8bc330b9-d680-c00a-4bc1-c35cb21d2b34@linux.microsoft.com>
Date:   Thu, 24 Sep 2020 13:05:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b8e9ee52-c0fd-a6cf-3054-4220636a60e9@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Forwarding this here since the final intent here is an IMA related 
change to see if anyone has any suggestions.


-------- Forwarded Message --------
Subject: 	How to extract linux kernel version information from a kernel 
image?
Date: 	Fri, 18 Sep 2020 12:47:13 -0700
From: 	Raphael Gianotti <raphgi@linux.microsoft.com>
To: 	linux-kernel@vger.kernel.org



Hi,

I have been investigating a way to extract the version strong from a 
kernel image (e.g., vmlinux). The version string I've been looking at is 
essentially the linux_banner symbol.

We'll use IMA to measure the version string on the kexec system call, 
providing a way for an attestation service, for instance, to attest to 
what version of the kernel is running on the client.

I haven't found a way to extract the version from the image that isn't 
simply searching the whole image for it. I was hoping someone here may 
be able to point me to a better approach to retrieve the linux_banner 
symbol value from an image or  any existing kernel code that does 
similar parsing.

If that matters for any suggestions, my current focus is on ARM64 images 
(if the code ends up having to be arch specific).

Thanks,

-Raphael

