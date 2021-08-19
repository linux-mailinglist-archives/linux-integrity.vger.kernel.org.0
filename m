Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10693F2165
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 22:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhHSUL7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 16:11:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232343AbhHSUL7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 16:11:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JK34kw007545;
        Thu, 19 Aug 2021 16:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=C3sPmaZ1zwKBetRUN+kVcm6InCc51IGq4JM450q4g1Q=;
 b=boF0N4mr2qwW1NCyWHd9sTgZxBGnId161NEyD+Fak0p8P/HDLc8VGsmU4yBbWgWbuuIO
 zHIBFipu4GvPSJLWjQSRphtPCKhVJfTauZtaJcz02yNuZazbiuvXw+A4aKfS/WGOtjG+
 +Q/1czYw/H68+xBFCFdHeNUHnXX/sbGFmh/djPR91ODMYlsNo83BdpJDx8bHQKeNdeAY
 S40L60Tud2JC22IgZXT5WuI0pfpZ31a0CSUHJ81fUiC9gv5kOqq39jjiVjuj2XUPaZfV
 o5GxHzvLOBaAShB0XjlOb9I8l5xEPvvgogUO/XB1uKhy/e3ZnStxpLnehzUjZDv0QvvZ yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahjgbpsnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 16:11:20 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JK3GCZ008195;
        Thu, 19 Aug 2021 16:11:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahjgbpskd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 16:11:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JJGYtf000730;
        Thu, 19 Aug 2021 20:11:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3ae5f8gpys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 20:11:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JK7iWQ55640548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 20:07:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4A3E4203F;
        Thu, 19 Aug 2021 20:11:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A437742049;
        Thu, 19 Aug 2021 20:11:13 +0000 (GMT)
Received: from sig-9-65-206-165.ibm.com (unknown [9.65.206.165])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Aug 2021 20:11:13 +0000 (GMT)
Message-ID: <948bd1cb9d77371da02381ede207a79165c7f6b1.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 19 Aug 2021 16:11:12 -0400
In-Reply-To: <YR6iotDjqKTsPOPw@glitch>
References: <20210819021136.664597-1-vt@altlinux.org>
         <600a9f93ca6e74621833cd9452a9dfd7b5a8d55a.camel@linux.ibm.com>
         <20210819181225.vo7dmtm3z5mnwmlh@altlinux.org> <YR6iotDjqKTsPOPw@glitch>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2T39Rl7vxiXoT5Lw9CDC0iSzP0ztS-De
X-Proofpoint-GUID: iB8cMLUnFJdIyvh-h7N1fkNKUzoJTjCT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_07:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=980 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-19 at 15:27 -0300, Bruno Meneguele wrote:
> On Thu, Aug 19, 2021 at 09:12:25PM +0300, Vitaly Chikunov wrote:
> > > > @@ -215,7 +236,10 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
> > > >  	}
> > > >  	len = stats.st_size;
> > > > 
> > > > -	data = malloc(len);
> > > > +	if (secure)
> > > > +		data = OPENSSL_secure_malloc(len);
> > > > +	else
> > > > +		data = malloc(len);
> > > 
> > > Without being able to apply the patch, it's hard to tell if there
> > > should be a preparatory patch that first replaces malloc() with
> > > OPENSSL_malloc(), and other similar changes.
> > 
> > There is no OPENSSL_malloc use and I don't see why it should be.
> > 
> 
> Keeping the OPENSSL_* calls as a meaning of "secure calls" while keeping
> the standard C library calls for "non-secure" seems indeed cleaner.

Ok

thanks,

Mimi

