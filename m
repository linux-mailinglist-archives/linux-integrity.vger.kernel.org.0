Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D9D71C3F
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jul 2019 17:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbfGWPxz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 11:53:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730033AbfGWPxz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 11:53:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NFrnUk059812
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 11:53:54 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tx3sqmasq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 11:53:49 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 23 Jul 2019 16:53:26 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 16:53:23 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NFrMWE61276170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 15:53:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E9654204C;
        Tue, 23 Jul 2019 15:53:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CE4942045;
        Tue, 23 Jul 2019 15:53:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.145])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 15:53:21 +0000 (GMT)
Subject: Re: [PATCH v2] ima-evm-utils: use tsspcrread to read the TPM 2.0
 PCRs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Petr Vorel <pvorel@suse.cz>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Tue, 23 Jul 2019 11:53:10 -0400
In-Reply-To: <20190723154759.GB16649@glitch>
References: <1563893743-4586-1-git-send-email-zohar@linux.ibm.com>
         <20190723154759.GB16649@glitch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072315-0016-0000-0000-00000295750E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072315-0017-0000-0000-000032F36616
Message-Id: <1563897190.14396.144.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=821 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230159
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-07-23 at 12:47 -0300, Bruno E. O. Meneguele wrote:

> > @@ -1402,6 +1400,41 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
> >  	return result;
> >  }
> >  
> > +#ifdef HAVE_TSSPCRREAD
> > +static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
> > +{
> > +	FILE *fp;
> > +	char pcr[100];	/* may contain an error */
> > +	char cmd[50];
> > +	int ret;
> > +
> > +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns 2> /dev/null", idx);
> > +	fp = popen(cmd, "r");
> > +	if (!fp) {
> > +		snprintf(pcr, sizeof(pcr), "popen failed: %s", strerror(errno));
> > +		*errmsg = strdup("popen failed:");
> 
> Should it have been 
> 
> *errmsg = strdup(pcr);
> 
Yes, of course.

thanks!

Mimi

