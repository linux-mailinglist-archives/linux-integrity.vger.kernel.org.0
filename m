Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB611E715
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 16:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfLMPvo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Dec 2019 10:51:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60950 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfLMPvo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Dec 2019 10:51:44 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7026620B7187;
        Fri, 13 Dec 2019 07:51:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7026620B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576252303;
        bh=VamZRT3RyyPdbHwxLZRTfXiZ1Bh2bvZ/QaCwK/05xRk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KEpg5cLK7KxN/GLfgvJ3dXvwLMsTMZ8LWoJ0CgTbgYIG90mrWYICoh7JhX6j3GOij
         8hs6aqk2cAAdURDB2TGhD/oxO/WoKdd5QgKMLG9LH4ep/gwFYInphHzJetz6oTHpG1
         nZ+Md1wyHdDrIl0bfuk2vBwwuz0pcYY9nmBsqf8I=
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key"
 measurements
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
 <20191213004250.21132-2-nramas@linux.microsoft.com>
 <1576202134.4579.189.camel@linux.ibm.com>
 <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
 <1576204377.4579.206.camel@linux.ibm.com>
 <c60341a3-2329-cd92-c76c-6f8249a57b43@linux.microsoft.com>
 <1576242406.4579.239.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9938ff03-5cf2-5396-1172-5734cc10819e@linux.microsoft.com>
Date:   Fri, 13 Dec 2019 07:51:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576242406.4579.239.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/13/19 5:06 AM, Mimi Zohar wrote:

> I just need to convince myself that this is correct.  Normally before
> reading and writing a flag, there is some sort of locking.  With
> taking the mutex before setting the flag, there is now only a lock
> around the single writer.
> 
> Without taking a lock before reading the flag, will the queue always
> be empty is the question.  If it is, then the comment is correct, but
> the code assumes not and processes the list again.  Testing the flag
> after taking the mutex just re-enforces the comment.
> 
> Bottom line, does reading the flag need to be lock protected?
> 
> Mimi
> 

I'll change this function to check the flag again after taking the lock 
and process only if the queue has entries. Will send an update today.

Please let me know if you have any concern in other functions in this 
file. I'll address them, if any, in today's update.

thanks,
  -lakshmi
