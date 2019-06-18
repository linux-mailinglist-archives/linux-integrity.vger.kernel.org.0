Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB254A879
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 19:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfFRRc4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 13:32:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728572AbfFRRc4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 13:32:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IHWsVJ038246
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jun 2019 13:32:55 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t728hxee3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jun 2019 13:32:53 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.ibm.com>;
        Tue, 18 Jun 2019 18:32:00 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 18:31:57 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5IHVu7R21823966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 17:31:56 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36106BE053;
        Tue, 18 Jun 2019 17:31:56 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59608BE04F;
        Tue, 18 Jun 2019 17:31:55 +0000 (GMT)
Received: from [9.85.173.87] (unknown [9.85.173.87])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jun 2019 17:31:55 +0000 (GMT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
To:     Jordan Hand <jorhand@linux.microsoft.com>,
        Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
 <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
 <5b160458-b4b8-470c-0123-8ce5525c5cb0@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Tue, 18 Jun 2019 13:31:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5b160458-b4b8-470c-0123-8ce5525c5cb0@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061817-0004-0000-0000-0000151DCEAD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011285; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01219834; UDB=6.00641654; IPR=6.01000975;
 MB=3.00027362; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-18 17:31:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061817-0005-0000-0000-00008C2163D4
Message-Id: <f6ce1524-d1ee-08b4-d7bc-f3337a804b98@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180140
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/10/2019 12:57 PM, Jordan Hand wrote:
> 
> Thought I'd jump in this conversation to see if I can clarify what I see 
> as the value of this patch set.
> 
> At a certain point, keeping a list of all known-good (or known-bad) 
> hashes becomes infeasible. We could probably disagree about at what 
> scale this happens but I think we could agree that eventually this 
> happens (let me know if you still disagree with this assertion). So at 
> this point you likely need to rely on a few things:

I've seen large systems with 60,000 measurements.  Even if that goes to 
100,000, *10 for bad measurements, and *10 for future expansion, that's 
only 10M, or 320 mbytes.  That's pennies of disk space.

> 
> (1) is the file >= <known good version>. This allows you to forbid any 
> kernel version before a vulnerability was fixed.

Perhaps, but one might also exclude a newer version, either because of a 
regression, a certification, etc.

> 
> (2) Was it signed with a good, trusted, production key.
> 
> You can sort of do this today by using the keyid. The issues with this 
> are (a) collision (though the chance may be pretty remote. I don't have 
> the crypto expertise to make an empirical call on that) and (b) you need 
> to know all the possible signing keys in the service.

The 4 byte key id was probably a long term mistake, but can be fixed. 
Today, a collision is remote.  Even then, just try both keys.  Nothing 
breaks.

> 
> Again, once you cross a certain scale threshold, signing/deployment is 
> so automated that the leaf key could change at any time, leaving your 
> service in the dark about new keys. You could automatically add new 
> trusted keys to the service but it depends on the service environment 
> and how much you want to automate what the service trusts.
> 
> So what does measuring the keyring do? It allows you to put long-lived 
> trusted CAs in .builtin_trusted_keys. On the service if you trust the CA 
> and you trust the running kernel to do the right thing during key 
> enrollment, you can trust that loaded files are properly signed.

This is my gap in understanding.

Even if I somewhat trust the keys on the built-in keyring, I may not 
trust every key on the IMA keyring.

I may trust the kernel that ran at the time the key was enrolled, but I 
don't trust the one that's currently running until I attest.  Or, are 
all the keys on both keyrings erased before any kernel SW update?  I 
don't think so.

