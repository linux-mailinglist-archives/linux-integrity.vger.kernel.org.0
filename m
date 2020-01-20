Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D20142104
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jan 2020 01:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgATANW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Jan 2020 19:13:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728841AbgATANV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Jan 2020 19:13:21 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K0BoJB082155
        for <linux-integrity@vger.kernel.org>; Sun, 19 Jan 2020 19:13:20 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmg5rndtb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 19 Jan 2020 19:13:20 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 20 Jan 2020 00:13:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 00:13:17 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00K0DGUh55705686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 00:13:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 512D352051;
        Mon, 20 Jan 2020 00:13:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.225.89])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D219D5204F;
        Mon, 20 Jan 2020 00:13:15 +0000 (GMT)
Subject: Re: ima pcr question
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 19 Jan 2020 19:13:15 -0500
In-Reply-To: <1579391500.3421.35.camel@HansenPartnership.com>
References: <20200114000602.h5k5rr2k6zl3dlts@cantor>
         <1578964659.5796.7.camel@linux.ibm.com>
         <20200117222920.2d42m3ahxznl64em@cantor>
         <1579302011.13499.9.camel@HansenPartnership.com>
         <20200118191414.m4gqggwfavkjlef4@cantor>
         <20200118232004.lt2u2u6ryitrkaa2@cantor>
         <1579391500.3421.35.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012000-0016-0000-0000-000002DEDBE4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012000-0017-0000-0000-000033417D49
Message-Id: <1579479195.5125.162.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-19_08:2020-01-16,2020-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-01-18 at 15:51 -0800, James Bottomley wrote:
> On Sat, 2020-01-18 at 16:20 -0700, Jerry Snitselaar wrote:
> > On Sat Jan 18 20, Jerry Snitselaar wrote:
> > > On Fri Jan 17 20, James Bottomley wrote:
> [...]
> > > > The implication seems to be that on a DELL setting the bios
> > > > default to sha256 turns off the TPM's sha1 pcr banks ... is that
> > > > the case?
> > > > 
> > > > tssgetcapability -cap 5
> > > > 
> > > > should confirm or deny this.
> > > > 
> > > > James
> > > > 
> > > 
> > > I believe so, I'm waiting to get access to the system here to
> > > double check. Before with the intel stack, tpm2_pcrlist -s would
> > > return both sha1 and sha256, but the plain tpm2_pcrlist command
> > > would show only banks for one or the other depending on which
> > > setting was in the bios. For the other it would just print
> > > out the algorithm and nothing else.
> > > 
> > > I should be able to run the tss2 command later today.
> > > 
> > > Regards,
> > > Jerry
> > 
> > with sha1 selected:
> > 
> > [root@dell-per830-01 ~]# tssgetcapability -cap 5
> > 2 PCR selections
> >      hash TPM_ALG_SHA1
> >      TPMS_PCR_SELECTION length 3
> >      ff ff ff 
> >      hash TPM_ALG_SHA256
> >      TPMS_PCR_SELECTION length 3
> >      00 00 00 
> > 
> > with sha256 selected:
> > 
> > [root@dell-per830-01 ~]# tssgetcapability -cap 5
> > 2 PCR selections
> >      hash TPM_ALG_SHA1
> >      TPMS_PCR_SELECTION length 3
> >      00 00 00 
> >      hash TPM_ALG_SHA256
> >      TPMS_PCR_SELECTION length 3
> >      ff ff ff 
> 
> OK, so that confirms the suspicion.  The only active bank is the one
> you've selected in the bios ... I suppose it was done to avoid having
> to measure through more than one bank, but it does mean IMA must cope
> in the case the sha1 bank isn't active.

Agreed, IMA needs to support calculating and extending the different
TPM banks with the correct digest values; and the IMA measurement list
format needs to be updated as well.  Patches have been posted to
address both of these issues, but were not ready to be upstreamed.
 Now that the TPM interface has been addressed, we can at least
address the first issue - calculating and extending the TPM with the
appropriate digest values.

For now, if the TPM SHA1 bank is not enabled, I suggest going into
TPM-bypass mode.  ima_init_digests() already walks the list of enabled
TPM banks.  Updating to check if a SHA1 bank is enabled should be
relatively straight forward.

Mimi

