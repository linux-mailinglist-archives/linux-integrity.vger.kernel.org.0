Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA0C10EF08
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfLBSS5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 13:18:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727671AbfLBSS5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 13:18:57 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2IIpke181265
        for <linux-integrity@vger.kernel.org>; Mon, 2 Dec 2019 13:18:56 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6my8mr3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Dec 2019 13:18:55 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Dec 2019 18:18:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Dec 2019 18:18:37 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB2IIaDa52363282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 18:18:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 444FB42041;
        Mon,  2 Dec 2019 18:18:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E96C4203F;
        Mon,  2 Dec 2019 18:18:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.147.107])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Dec 2019 18:18:35 +0000 (GMT)
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Mon, 02 Dec 2019 13:18:34 -0500
In-Reply-To: <18b30666-7c44-f81e-8515-189052007e47@linux.microsoft.com>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
         <20191127015654.3744-6-nramas@linux.microsoft.com>
         <1574880741.4793.292.camel@linux.ibm.com>
         <18b30666-7c44-f81e-8515-189052007e47@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120218-0028-0000-0000-000003C39241
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120218-0029-0000-0000-00002486A8F0
Message-Id: <1575310714.4793.420.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_04:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=2 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912020155
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-27 at 16:44 -0800, Lakshmi Ramasubramanian wrote:
> On 11/27/19 10:52 AM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> >> +static bool ima_match_keyring(struct ima_rule_entry *rule,
> >> +			      const char *keyring)
> >> +{
> >> +	/*
> >> +	 * "keyrings=" is specified in the policy in the format below:
> >> +	 *   keyrings=.builtin_trusted_keys|.ima|.evm
> >> +	 *
> >> +	 * Each keyring name in the option is separated by a '|' and
> >> +	 * the last keyring name is null terminated.
> >> +	 *
> >> +	 * The given keyring is considered matched only if
> >> +	 * the whole keyring name matched a keyring name specified
> >> +	 * in the "keyrings=" option.
> >> +	 */
> >> +	p = strstr(rule->keyrings, keyring);
> >> +	if (p) {
> >> +		/*
> >> +		 * Found a substring match. Check if the character
> >> +		 * at the end of the keyring name is | (keyring name
> >> +		 * separator) or is the terminating null character.
> >> +		 * If yes, we have a whole string match.
> >> +		 */
> >> +		p += strlen(keyring);
> >> +		if (*p == '|' || *p == '\0')
> >> +			return true;

This code checks that the keyring name isn't suffixed, but not
prefixed.

> >> +	}
> >> +
> > 
> > Using "while strsep()" would simplify this code, removing the need for
> > such a long comment.
> > 
> > Mimi
> 
> strsep() modifies the source string (replaces the delimiter with '\0' 
> and also updates the source string pointer). I am not sure it can be 
> used for our scenario. Please correct me if I am wrong.
> 
> Initial IMA policy:
> -------------------
> measure func=KEY_CHECK 
> keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist template=ima-buf
> 
> Policy after adding a key to .ima keyring:
> ------------------------------------------
> measure func=KEY_CHECK keyrings=.evm|.builtin_trusted_keys|.blacklist 
> template=ima-buf
> 
> Policy after adding a key to a keyring that is not listed in the policy:
> ------------------------------------------------------------------------
> measure func=KEY_CHECK keyrings= template=ima-buf
> 
> ********************************************************************************
> 
> Please see the description from the man page for strsep():
> 
> http://man7.org/linux/man-pages/man3/strsep.3.html
> 
> char *strsep(char **stringp, const char *delim);
> 
> This function finds the first token in the string *stringp, that is 
> delimited by one of the bytes in the string delim.  This token is 
> terminated by overwriting the delimiter with a null byte ('\0'), and 
> *stringp is updated to point past the token.

Yes, you would have to make a copy of the string before using
strsep().  You could always use kstrdup(), remembering to free it, or
allocate the memory just once, and then just use memcpy.

Mimi

