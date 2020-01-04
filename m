Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685CE1303E9
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Jan 2020 19:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgADSw7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Jan 2020 13:52:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48370 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgADSw7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Jan 2020 13:52:59 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id C39E6200889D;
        Sat,  4 Jan 2020 10:52:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C39E6200889D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578163978;
        bh=pwQx2YjPnUcpJYfYcekyvDOKrUBVyrdH69s2yDtp3K0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=moDqmWY2vCcGSywVfdpW7YFHBDnJDgUlonXOuQrwMlbYw794UbOlM55rMCcpfAmLw
         GrsCi+vulh6KkYEF76S8oBXzafRDDG/jauOKU+3MoAcpAliXs3GXXvt/w34Khk/tAV
         XE7gC6P/ONzIoAhH3wlMjsIZGO4h4iRrFWiQyJeI=
Subject: Re: ERROR: "process_buffer_measurement"
 [security/integrity/ima/ima_asymmetric_keys.ko] undefined!
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <202001050229.ig7cUcrs%lkp@intel.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ae08cbb4-82f4-c6d7-b5cf-860874319a46@linux.microsoft.com>
Date:   Sat, 4 Jan 2020 10:53:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <202001050229.ig7cUcrs%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/4/2020 10:37 AM, kbuild test robot wrote:

>     WARNING: modpost: missing MODULE_LICENSE() in security/integrity/ima/ima_asymmetric_keys.o
>     see include/linux/module.h for more information

The new file ima_asymmetric_keys.c does have the license header (similar 
to the license header in other files in IMA folder). Did I missing 
something?

>>> ERROR: "process_buffer_measurement" [security/integrity/ima/ima_asymmetric_keys.ko] undefined!

process_buffer_measurement() is defined ima_main.c - this function was 
updated in Nayna's patch and I had updated it.

thanks,
  -lakshmi


