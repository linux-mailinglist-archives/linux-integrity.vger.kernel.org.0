Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885A118A76E
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Mar 2020 22:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRVzF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Mar 2020 17:55:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbgCRVzB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Mar 2020 17:55:01 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ILWb0X185066
        for <linux-integrity@vger.kernel.org>; Wed, 18 Mar 2020 17:55:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8adpwvk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 18 Mar 2020 17:55:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 18 Mar 2020 21:54:57 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 21:54:55 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02ILrrgZ39649772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 21:53:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C0BD5204E;
        Wed, 18 Mar 2020 21:54:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.207.40])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4565352051;
        Wed, 18 Mar 2020 21:54:53 +0000 (GMT)
Subject: Re: [PATCH v3 7/8] ima: Calculate and extend PCR with digests in
 ima_template_entry
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Wed, 18 Mar 2020 17:54:52 -0400
In-Reply-To: <fecf59c1880045769bfecc17b5670ac5@huawei.com>
References: <20200210100418.22049-1-roberto.sassu@huawei.com>
         <1583208222.8544.168.camel@linux.ibm.com>
         <fecf59c1880045769bfecc17b5670ac5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031821-4275-0000-0000-000003AEABFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031821-4276-0000-0000-000038C3D8E2
Message-Id: <1584568492.5188.200.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180092
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-03-18 at 12:42 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: owner-linux-security-module@vger.kernel.org [mailto:owner-linux-
> > security-module@vger.kernel.org] On Behalf Of Mimi Zohar
> > Sent: Tuesday, March 3, 2020 5:04 AM
> > To: Roberto Sassu <roberto.sassu@huawei.com>;
> > James.Bottomley@HansenPartnership.com;
> > jarkko.sakkinen@linux.intel.com
> > Cc: linux-integrity@vger.kernel.org; linux-security-module@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Silviu Vlasceanu
> > <Silviu.Vlasceanu@huawei.com>
> > Subject: Re: [PATCH v3 7/8] ima: Calculate and extend PCR with digests in
> > ima_template_entry
> > 
> > On Mon, 2020-02-10 at 11:04 +0100, Roberto Sassu wrote:
> > 
> > > @@ -219,6 +214,8 @@ int ima_restore_measurement_entry(struct
> > ima_template_entry *entry)
> > >
> > >  int __init ima_init_digests(void)
> > >  {
> > > +	u16 digest_size;
> > > +	u16 crypto_id;
> > >  	int i;
> > >
> > >  	if (!ima_tpm_chip)
> > > @@ -229,8 +226,17 @@ int __init ima_init_digests(void)
> > >  	if (!digests)
> > >  		return -ENOMEM;
> > >
> > > -	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
> > > +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
> > >  		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
> > > +		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
> > > +		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
> > > +
> > > +		/* for unmapped TPM algorithms digest is still a padded
> > SHA1 */
> > > +		if (crypto_id == HASH_ALGO__LAST)
> > > +			digest_size = SHA1_DIGEST_SIZE;
> > > +
> > > +		memset(digests[i].digest, 0xff, digest_size);
> > 
> > Shouldn't the memset here be of the actual digest size even for
> > unmapped TPM algorithms.
> 
> This is consistent with ima_calc_field_array_hash(), so that a verifier
> will always pad the SHA1 digest with zeros to obtain the final PCR value.
> 
> I can set all bytes if you prefer.

My concern is with violations.  The measurement list will be padded
with 0's, but the value being extended into the TPM will only
partially be 0xFF's.  When verifying the measurement list, replacing
all 0x00's with all 0xFF's is simpler.

Mimi

