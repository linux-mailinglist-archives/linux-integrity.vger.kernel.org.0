Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EA21F7DCA
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2020 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFLTuR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 15:50:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60316 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgFLTuP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 15:50:15 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B356C205DDAF;
        Fri, 12 Jun 2020 12:50:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B356C205DDAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591991414;
        bh=GdD9+kQ9aITh+TAeiBW5btAMPcCymvbqsDCBMG9pDJY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VnnOl8MDm+ruzYyoWNTT6EMXTeW1KeweCnFkTcpwagJQWqkhh3u2nYF34qqGdvPBo
         aKpmwhEtVxIJ52SRseNK4B+wSrg34/L38VYKHNrJKNIGKH9mAEuhek8tb571EKHoaS
         LUA0x4yXrn6jiMXz029ksb3O+OHqmzVjEI6yk2LE=
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
To:     Mimi Zohar <zohar@linux.ibm.com>, sgrubb@redhat.com,
        paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
 <1591989920.11061.90.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <42482562-d74c-2678-069f-1d8ef4feffac@linux.microsoft.com>
Date:   Fri, 12 Jun 2020 12:50:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591989920.11061.90.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/12/20 12:25 PM, Mimi Zohar wrote:

> The idea is a good idea, but you're assuming that "result" is always
> errno.  That was probably true originally, but isn't now.  For
> example, ima_appraise_measurement() calls xattr_verify(), which
> compares the security.ima hash with the calculated file hash.  On
> failure, it returns the result of memcmp().  Each and every code path
> will need to be checked.
> 

Good catch Mimi.

Instead of "errno" should we just use "result" and log the value given 
in the result parameter?

 From the audit field dictionary (link given below) "result" is already 
a known field that is used to indicate the result of the audited operation.

@Steve\Paul:
Like "res" is "result" also expected to have only values "0" or "1", or 
can it be any result code?

https://github.com/linux-audit/audit-documentation/blob/master/specs/fields/field-dictionary.csv

res 	alphanumeric 	result of the audited operation(success/fail) 	

result 	alphanumeric 	result of the audited operation(success/fail)

thanks,
  -lakshmi
