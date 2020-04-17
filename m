Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E781AD3D7
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2020 02:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgDQAwG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 20:52:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56274 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgDQAwG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 20:52:06 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6153720B4737;
        Thu, 16 Apr 2020 17:52:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6153720B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1587084725;
        bh=Kc9vbyWANy9NqImaMvoEFw8DXdkj1IeIHyGCoq6h7os=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FKSLSHe1ocGFsx+cS4/k1BV5pKS5njlwZv47XWo1bGojsxMEjJLAm2qVR/L9IpDdL
         YrJvLvvDIchtfd5gayScARGGcOPTbKVFhJDiHiDx5G1CJXzfVWQ0Q9+plc61cyLKiv
         0FrFgXsS4RvaVVQZRVo8LBvuIGD5s4oNfKuyMSwA=
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     "Lev R. Oshvang ." <levonshe@gmail.com>,
        Stephen Smalley <stephen.smalley@gmail.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>, dm-devel@redhat.com,
        James Morris <jmorris@namei.org>, chpebeni@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@microsoft.com,
        sashal@kernel.org, suredd@microsoft.com
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
 <CAB9W1A1=JyOV3-+6jn3xX-M+GKWBB2cCNh-VWB_kzf+YiR_d2Q@mail.gmail.com>
 <CAP22eLGJbSvUU=W0Jp=gvOFv-nxLC8YTnta3OU2PKbh746MCkQ@mail.gmail.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <e0e214c7-09d2-46c1-fe63-febd23488720@linux.microsoft.com>
Date:   Thu, 16 Apr 2020 17:52:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAP22eLGJbSvUU=W0Jp=gvOFv-nxLC8YTnta3OU2PKbh746MCkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-04-12 1:15 a.m., Lev R. Oshvang . wrote:
<snip>
> 
> It sees to me that  LKRG (kernel run time guard)  takes the role of
> measuring kernel structures.  Perhaps you need to consult with LKRG
Thanks Lev for the feedback. I will investigate more into it.
> guys.
> Lev.
> 
