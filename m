Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1943131390
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 15:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAFO1X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 09:27:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgAFO1X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 09:27:23 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006EQvmu127204
        for <linux-integrity@vger.kernel.org>; Mon, 6 Jan 2020 09:27:22 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb93jc3df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jan 2020 09:27:22 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 006EQJO7021372
        for <linux-integrity@vger.kernel.org>; Mon, 6 Jan 2020 14:27:27 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 2xajb62qe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jan 2020 14:27:27 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 006ERIus49938940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 14:27:18 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E427BE054;
        Mon,  6 Jan 2020 14:27:18 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DBCFBE051;
        Mon,  6 Jan 2020 14:27:18 +0000 (GMT)
Received: from [9.2.202.58] (unknown [9.2.202.58])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jan 2020 14:27:17 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
 <1577996725.5874.114.camel@linux.ibm.com>
 <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
 <1578007322.5874.128.camel@linux.ibm.com>
 <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
 <1578180770.5152.30.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <7958a6d2-d7ca-98b2-55b7-def1675fb674@linux.ibm.com>
Date:   Mon, 6 Jan 2020 09:27:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578180770.5152.30.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=766
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/4/2020 6:32 PM, Mimi Zohar wrote:
> The "ima-modsig" template may include the "sig" and/or the "modsig"
> fields.  As the "d-modsig" and "modsig" are tied together, either both
> are defined or neither are defined.  The file hash ("d-ng") must
> always exist.
That's clear for the predefined (is there a formal term for them?) 
templates.  How would this be specified when IMA permits custom templates?

E.g., I can create a template 'modsig', I have the signature but not the 
file data hash.  I can create a template 'd-modsig' that has the file
data hash but no signature.

With custom templates, the attacker can create any IMA log, and the 
parser has to handle it.

Note:  When you say "either both are defined or neither is defined", 
this may be enforced by the official IMA code.  However, the attacker is 
free to modify the IMA code to send any log it likes.  The parser has to 
know what to do.

That is, an event log specification (which I'm trying to write) has to 
state precisely that the dependencies are and what should be rejected. 
For example, it might say (if this is corrct):

1 - If d-modsig is present, modsig MUST be present.  Else error.
2 - If modsig is present, d-modsig MUST be present.
3 - If ???, d-ng MUST be present.


