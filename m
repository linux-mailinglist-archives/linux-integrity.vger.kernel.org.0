Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AAE774E
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2019 18:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbfJ1RIt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Oct 2019 13:08:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404041AbfJ1RIt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Oct 2019 13:08:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9SH7D4b103032
        for <linux-integrity@vger.kernel.org>; Mon, 28 Oct 2019 13:08:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vx16xrc8y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 28 Oct 2019 13:08:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 28 Oct 2019 17:08:45 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Oct 2019 17:08:41 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9SH8eA143516212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 17:08:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50D4B4203F;
        Mon, 28 Oct 2019 17:08:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BD2842041;
        Mon, 28 Oct 2019 17:08:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.151.87])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Oct 2019 17:08:38 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] KEYS: Added BUILTIN_TRUSTED_KEYS enum to measure
 keys added to builtin_trusted_keys keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Mon, 28 Oct 2019 13:08:38 -0400
In-Reply-To: <8494baa1-c4db-f08b-26c9-2e56279075d0@linux.microsoft.com>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
         <20191023233950.22072-4-nramas@linux.microsoft.com>
         <1572186810.4532.206.camel@linux.ibm.com>
         <8494baa1-c4db-f08b-26c9-2e56279075d0@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102817-0020-0000-0000-000003804EA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102817-0021-0000-0000-000021D653C1
Message-Id: <1572282518.4532.260.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=993 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910280166
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-10-28 at 08:12 -0700, Lakshmi Ramasubramanian wrote:
> On 10/27/19 7:33 AM, Mimi Zohar wrote:
> 
> > .builtin_trusted_keys is a trusted keyring, which is created by the
> > kernel.  It cannot be deleted or replaced by userspace, so it should
> > be possible to correlate a keyring name with a keyring number on
> > policy load.
> 
> Yes - at policy load we can map a keyring name to a keyring number.
> 
> But at runtime we still need to know if the keyring parameter passed to 
> the IMA hook function is configured to be measured.
> 
> void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> 				   unsigned long flags, bool create);
> {
>     => Get the keyring number for the given "keyring".

There is no "getting" involved here.  Pass "keyring" to
process_buffer_measurement and on to ima_get_action().

>     => Check if the keyring number is in the configured IMA policy.

ima_get_action() should do a simple compare of the valued stored in
the IMA policy with the value returned by key_serial().

Mimi

>     => If yes, measure the key.
>     => Else, do nothing.
> }

> Did I misunderstand what you had stated?

