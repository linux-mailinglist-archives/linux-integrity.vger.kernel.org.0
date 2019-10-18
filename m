Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48EDD07C
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Oct 2019 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502988AbfJRUiO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Oct 2019 16:38:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44000 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfJRUiN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Oct 2019 16:38:13 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 47DF4200871E;
        Fri, 18 Oct 2019 13:38:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47DF4200871E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571431092;
        bh=t/0Ocm7mOruVR9iO0ZzF4XqusnlGjzTV5TbKjXjaLYY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TwPL4DdglDaPi/JqvU/7StYcfvAHj2ZUF58ekIbpWtMGN7E9y+y/e82XDFn23KdOn
         6JgxKpTmR5WcXsQ+VYcTV2JwFhawD0RMSbsTJ3r/AcHzG187xz+M0ZYEJcLPlaqH3H
         8M/cdHyQcoYVSgoEhZlzKNWYPBUZ0+AlvEHSyvrM=
Subject: Re: [PATCH v0] KEYS: Security LSM Hook for key_create_or_update
To:     Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        sashal@kernel.org, jamorris@linux.microsoft.com
Cc:     msft-linux-kernel@linux.microsoft.com, prsriva@linux.microsoft.com
References: <20191018195328.6704-1-nramas@linux.microsoft.com>
 <e5ffe76e-ff9f-7542-2ff7-3ede4f911c2a@schaufler-ca.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <48a4db30-853b-ef6b-9d35-77ae0450b65d@linux.microsoft.com>
Date:   Fri, 18 Oct 2019 13:38:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e5ffe76e-ff9f-7542-2ff7-3ede4f911c2a@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/18/19 1:25 PM, Casey Schaufler wrote:

>> Problem Statement:
>> key_create_or_update function currently does not have
>> a security LSM hook. The hook is needed to allow security
>> subsystems to use key create or update information.
> 
> What security module(s) do you expect to use this?

SELinux is one that I can think of - it has hooks for key_alloc, 
key_free, etc. But does not have one for key_create_or_update.
> IMA is not a Linux Security Module.

Agree. But ima utilizes LSM to hook into system operations (such as 
read_file given below).
int security_kernel_post_read_file(struct file *file, char *buf,
                                    loff_t size,
				   enum kernel_read_file_id id)
{
	int ret;

	ret = call_int_hook(kernel_post_read_file, 0, file,
                             buf, size, id);
	if (ret)
		return ret;
	return ima_post_read_file(file, buf, size, id);
}

I am currently working on an ima function to measure keys. The change 
set I have submitted today is in preparation for that.
> You don't have a security module that provides this hook.
> We don't accept interfaces without users.

Like I have mentioned above, that change in ima will be submitted for 
review shortly.

If you have suggestions for a better way to hook into key create\update 
that ima can use to measure keys, I'll be happy to investigate that.

thanks,
  -lakshmi
