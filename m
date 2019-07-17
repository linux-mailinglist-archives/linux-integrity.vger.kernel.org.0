Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8356BCF1
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfGQNXw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 09:23:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbfGQNXw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 09:23:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HDDntE120408
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 09:23:51 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tt46ps3jr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 09:23:51 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 17 Jul 2019 14:23:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Jul 2019 14:23:46 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6HDNjG839714832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 13:23:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 869FEA4040;
        Wed, 17 Jul 2019 13:23:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26DE4A4055;
        Wed, 17 Jul 2019 13:23:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.107])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Jul 2019 13:23:45 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima_evm_utils: limit duplicate "Failed to open
 keyfile" messages
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Wed, 17 Jul 2019 09:23:34 -0400
In-Reply-To: <20190716214948.6ycejuln6q376ngc@altlinux.org>
References: <1563287417-31780-1-git-send-email-zohar@linux.ibm.com>
         <1563287417-31780-2-git-send-email-zohar@linux.ibm.com>
         <20190716214948.6ycejuln6q376ngc@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071713-0008-0000-0000-000002FE592A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071713-0009-0000-0000-0000226BD3E5
Message-Id: <1563369814.4539.290.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=884 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170161
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Vitaly,

On Wed, 2019-07-17 at 00:49 +0300, Vitaly Chikunov wrote:
> >  EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
> >  {
> >  	FILE *fp;
> >  	X509 *crt = NULL;
> >  	EVP_PKEY *pkey = NULL;
> > +	int found;
> >  
> >  	if (!keyfile)
> >  		return NULL;
> >  
> >  	fp = fopen(keyfile, "r");
> >  	if (!fp) {
> > -		log_err("Failed to open keyfile: %s\n", keyfile);
> > +		found = lookup_keyfile_name(keyfile);
> > +		if (!found)
> > +			log_err("Failed to open keyfile: %s\n", keyfile);
> >  		return NULL;
> 
> 
> Now filename list is decoupled from keys themselves. Also we have key
> list creation in init_public_keys(). Maybe we should just always call
> init_public_keys for verify operations?

With v2 of "ima_evm_utils: erroneous "verification failed: 0 (invalid
padding)" message", I was able to drop this patch.

Mimi

