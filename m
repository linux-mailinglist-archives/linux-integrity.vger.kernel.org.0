Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0262629312C
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgJSWWt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 18:22:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58524 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgJSWWs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 18:22:48 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 33D1D20B4905;
        Mon, 19 Oct 2020 15:22:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33D1D20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603146168;
        bh=FdNXvqgCzXQNeZCRcBoIAJwxAmC8HJ2Nb5FyuizG/qM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QmiHwYxtf7kFD+i3OnhGNjsJ9vTszryzzmKK0yXhvq8JrY/A30RbadJ/wd3gvGIZ9
         sTVU5gBb7QvJiYqNK9oALCt5fxcmNggydvAtsFEjJjxfZa+rK7727r1TaKBuia7AUp
         v3WusLytzDXa9j8s7UG82C8zt3lvRc+XFGrgiIQc=
Subject: Re: [PATCH] file2bin: Pass the right values to size and count
 parameters for fread()
To:     Mimi Zohar <zohar@linux.ibm.com>, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org
References: <20201019200526.12678-1-nramas@linux.microsoft.com>
 <9dd83103f724484a8f1febb37b54616d136930fe.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <d4c7c8f3-e6b4-a962-c402-88982f86b79f@linux.microsoft.com>
Date:   Mon, 19 Oct 2020 15:22:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9dd83103f724484a8f1febb37b54616d136930fe.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/19/20 3:12 PM, Mimi Zohar wrote:
> Hi Lakshmi,
> 
> On Mon, 2020-10-19 at 13:05 -0700, Lakshmi Ramasubramanian wrote:
>> The 2nd parameter to fread() namely "size" specifies the size, in
>> bytes of each element to be read, and the 3rd parameter namely "count"
>> specifies the number of elements, each one with a size of "size" bytes.
>>
>>   size_t fread ( void * ptr, size_t size, size_t count, FILE * stream );
>>
>> But in the function file2bin() the values passed to "size" and "count"
>> are reversed causing the function to return an error eventhough the file
>> was sucdessfully read.
>>
>> Pass the right values to "size" and "count" parameters for fread() in
>> the function file2bin().
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   src/evmctl.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/evmctl.c b/src/evmctl.c
>> index 7ad1150..d49988e 100644
>> --- a/src/evmctl.c
>> +++ b/src/evmctl.c
>> @@ -221,7 +221,8 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
>>   		fclose(fp);
>>   		return NULL;
>>   	}
>> -	if (fread(data, len, 1, fp) != len) {
>> +
>> +	if (fread(data, 1, len, fp) != len) {
>>   		log_err("Failed to fread %zu bytes: %s\n", len, name);
>>   		fclose(fp);
>>   		free(data);
> 
> Wasn't this problem addressed by Vitaly's patch.  Please look at commit
> c89e8508864b ("ima-evm-utils: Fix reading of sigfile").
> 

You are right Mimi. I missed the patch posted by Vitaly. Sorry for the 
duplicate one.

Looks like Vitaly's change hasn't been merged to "master" branch yet in 
https://github.com/pevik/ima-evm-utils

thanks,
  -lakshmi



