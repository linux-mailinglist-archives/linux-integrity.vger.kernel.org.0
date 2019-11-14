Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F4159FCD12
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 19:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKNSSf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 13:18:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58844 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfKNSSf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:35 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8A02920B4901;
        Thu, 14 Nov 2019 10:18:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A02920B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573755514;
        bh=sd/+ILMW3HOqjjFdPZLW7teDwHtSzje14R12p9PHhCU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=R+xEQD03lHZZp9wEAvnUW+jsln5ODyo3ery21KtNljMyvzsUuif5WEEblErSAAgE4
         9q1azVU9c/JfGQQO1EeMKuEqjmw7JroeNynEbKdNdhNUb4racJb0BwsmMZQZjtYppu
         qpR1Mfp7la6gCUJxogsHk8xU4tujRYsuDpYaj/4U=
Subject: Re: [PATCH v7 4/5] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
 <20191114031202.18012-5-nramas@linux.microsoft.com>
 <1573742237.4793.30.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1deec85d-78b1-0cf2-ec2c-7dacaa2c3672@linux.microsoft.com>
Date:   Thu, 14 Nov 2019 10:18:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573742237.4793.30.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/14/2019 6:37 AM, Mimi Zohar wrote:
> Keyrings may be created by userspace with any name (e.g. foo, foobar,
> ...).  A keyring name might be a subset of another keyring name.  For
> example, with the policy "keyrings=foobar", keys being loaded on "foo"
> would also be measured.  Using strstr() will not achieve what is
> needed.
> 
> Mimi

Very good catch - I missed that :(

Will fix and send an update.

thanks,
  -lakshmi

