Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1347A23AA51
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHCQOR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 12:14:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45100 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHCQOR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 12:14:17 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A5D5E20B4908;
        Mon,  3 Aug 2020 09:14:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5D5E20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596471256;
        bh=nQqAWtDafDKA8mvQC2Nbk6iiZBioPMz9F6PAHCzIvMA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Wi4GLNyxXNsjpUC7/KNgmutcSEFnt523xFyHy3Nx9pWgcgVbSWqWxnnWeQdUUW7gw
         tJbP19VcLTOAsLnJ1XaSY9ZcdcgkJ+7Fo5JzItBTYEBAapr06o8wz5Vng0Bs1TcIFF
         C5gp0mKqNHpLGeEia2tBJXdezdoJvQK/c98DannM=
Subject: Re: [PATCH v5 3/4] LSM: Define SELinux function to measure state and
 policy
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        zohar@linux.ibm.com, casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-4-nramas@linux.microsoft.com>
 <dfd6f9c8-d62a-d278-9b0e-6b1f5ad03d3e@gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6371efa9-5ae6-05ac-c357-3fbe1a5a93d5@linux.microsoft.com>
Date:   Mon, 3 Aug 2020 09:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dfd6f9c8-d62a-d278-9b0e-6b1f5ad03d3e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/3/20 8:11 AM, Stephen Smalley wrote:
> 
> Possibly I'm missing something but with these patches applied on top of 
> next-integrity, and the following lines added to /etc/ima/ima-policy:
> 
> measure func=LSM_STATE template=ima-buf
> measure func=LSM_POLICY
> 
> I still don't get the selinux-state or selinux-policy-hash entries in 
> the ascii_runtime_measurements file.  No errors during loading of the 
> ima policy as far as I can see.
> 

Could you please check if the following config is set?
CONFIG_IMA_QUEUE_EARLY_BOOT_DATA=y

Try changing /sys/fs/selinux/checkreqprot and check 
ascii_runtime_measurements file again?

Also, could you please check if
/sys/kernel/security/integrity/ima/policy contains LSM_STATE and 
LSM_POLICY entries?

  -lakshmi


