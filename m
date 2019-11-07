Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38CF39D5
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2019 21:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKGUxR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Nov 2019 15:53:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbfKGUxR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Nov 2019 15:53:17 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7Kq7Ud037719
        for <linux-integrity@vger.kernel.org>; Thu, 7 Nov 2019 15:53:16 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w4t4f99n1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 07 Nov 2019 15:53:16 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 7 Nov 2019 20:53:14 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 20:53:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7KrAXc56688844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 20:53:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C274EAE059;
        Thu,  7 Nov 2019 20:53:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CF7DAE045;
        Thu,  7 Nov 2019 20:53:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.204.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 20:53:09 +0000 (GMT)
Subject: Re: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on
 key create or update
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Nov 2019 15:53:08 -0500
In-Reply-To: <7ce84aa0-729e-c58e-f16a-25490b4e336d@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
         <20191106190116.2578-2-nramas@linux.microsoft.com>
         <1573080189.5028.313.camel@linux.ibm.com>
         <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
         <1573098037.5028.325.camel@linux.ibm.com>
         <7ce84aa0-729e-c58e-f16a-25490b4e336d@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110720-0016-0000-0000-000002C1B452
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110720-0017-0000-0000-00003323389A
Message-Id: <1573159988.5028.400.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070196
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-11-07 at 10:42 -0800, Lakshmi Ramasubramanian wrote:
> On 11/6/2019 7:40 PM, Mimi Zohar wrote:
> 
> >>> I would move the patch that defines the "keyring=" policy option prior
> >>> to this one.  Include the call to process_buffer_measurement() in this
> >>> patch.  A subsequent patch would add support to defer measuring the
> >>> key, by calling a function named something like
> >>> ima_queue_key_measurement().
> >>>
> >>
> >> As I'd stated in the other response, I wanted to isolate all key related
> >> code in a separate C file and build it if and only if all CONFIG
> >> dependencies are met.
> > 
> > The basic measuring of keys shouldn't be any different than any other
> > policy rule, other than it is a key and not a file.  This is the
> > reason that I keep saying start out with the basics and then add
> > support to defer measuring keys on the trusted keyrings.
> 
> I'll make the changes, rearrange the patches and send an updated set.
> 
> I do have a few questions since I am still not fully understanding the 
> requirements you are targeting. Appreciate if you could please clarify.
> 
> As you already know, I am using the "public key" of the given asymmetric 
> key as the "buffer" to measure in process_buffer_measurement().
> 
> The measurement decision is not based on whether the keyring is a 
> trusted one or an untrusted one. As long as the IMA policy allows 
> (through the "keyrings=" option) the key will be measured.

We should be able to measure all keys being loaded onto any keyring or
onto a specific "keyring=".   This shouldn't be any different than any
other policy rule.  Once you have this basic feature working, you
would address loading keys during early boot.

> 
> Do you want only trusted keyrings to be allowed in the measurement?
> In my opinion, that decision should be deferred to whoever is setting up 
> the IMA policy.

Right, but it shouldn't be limited to just "trusted" keyrings.  This
way you can first test loading keys onto any keyring.

> 
> > Only the queueing code needed for measuring keys on the trusted
> > keyrings would be in a separate file.
> > 
> 
> The decision to process key immediately or defer (queue) is based on 
> whether IMA has been initialized or not. Keyring is not used for this 
> decision.
> 
> Could you please clarify how queuing is related to keyring's 
> trustworthiness?
> 
> The check for whether the key is an asymmetric one or not, and 
> extracting the "public key" if it is an asymmetric key needs to be in a 
> separate file to handle the CONFIG dependencies in IMA.

Queuing the keys should be independent of measuring the keys.
 Initially you would start with just measuring the key.  From a high
level it would look like:

    ima_post_key_create_or_update(...)
    {
       "measure key based on
    policy(key, keyring, ...)"
    }

This requires the IMA "keyring=" policy option support be defined
first.

Subsequently you would add key queuing support, and then update
ima_post_key_create_or_update().  It would look like:

        ima_post_key_create_or_update(...)
        {
            if (custom policy is loaded)
               "measure key based on policy(key, keyring, ...)"
            else
                "queue key(key, keyring)"
        }

Mimi

