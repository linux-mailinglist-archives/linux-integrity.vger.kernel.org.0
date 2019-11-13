Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E220DFBB55
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 23:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKMWEg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 17:04:36 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55152 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMWEg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 17:04:36 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4BF8D20B4901;
        Wed, 13 Nov 2019 14:04:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BF8D20B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573682675;
        bh=LGBeFAOxLhfup7BAgRv7Nz5ts8GZ5zBNR3ijacSdcMk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=axo5Djcdy6cv9SHTk8hTwACGCz3xw8Vb8g87o+Ga7NpvNtisD0toFpYOY+Hb+aVuH
         bKlo53aEao2VuidzicNXnnlFFb7l7FaBuZ53MSBOE6xcwwzeK89HheBIFn/g27l9HV
         pFyFEfM1ZZpMJwTdvs9+uMVq0cXvNIoHrZOBDKBg=
Subject: Re: [PATCH v6 0/3] KEYS: Measure keys when they are created or
 updated
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
 <1573682528.4793.3.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2cdcb5c0-e777-4d92-8d88-fa9383a8b05a@linux.microsoft.com>
Date:   Wed, 13 Nov 2019 14:04:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573682528.4793.3.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/13/2019 2:02 PM, Mimi Zohar wrote:

> 
> When re-posting this patch set, please include the support for
> specifying the "keyrings=" policy option, as an additional patch.
> 
> Mimi

Sure - will do.

thanks,
  -lakshmi

