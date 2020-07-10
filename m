Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8120A21B601
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGJNM7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 09:12:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48070 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJNM6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 09:12:58 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <marcelo.cerri@canonical.com>)
        id 1jtsp8-00089B-Jt
        for linux-integrity@vger.kernel.org; Fri, 10 Jul 2020 13:12:18 +0000
Received: by mail-qv1-f71.google.com with SMTP id v10so3621847qvm.17
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 06:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oNX4JqOH7+J58D38RosEj5TYyVoSsqkoHOjEB6jgk7Y=;
        b=EvaygD9xbZLLO0n5Vbh43gQrpgI4fVD7Ch3pKYyQNXRfWRs930XRSey9DEaCqTryNi
         p4vZFKGsikwf870tTCbTEV9Rnb8MMfzxBCwrbAbgIpNS3XrR9TtbQY6fGiDsxnx0uDpl
         DoFD+h5+dnHgYWtH9BeP30n6tOQdSIHzCTq+RxDk+vzRGVzJlOyJ0DWvoB/9nXyzyYpV
         ozAH+q79UmA2qtqt0VpRxFm9kLlrlaht4ob8h94HusDTX6L807Yv9emc5bVy9X3bJHLh
         g468MCLXAkqU6b2c9FtuzKk8zBSQMDtaUJiS4+TKMOjldQUaBUtopKRalzjd45axDpp6
         Araw==
X-Gm-Message-State: AOAM5336PbSkvMiFSB4thgXzDlt99X19sIKVaNv7jnoKvP5r04/fn5dC
        tfSX5CRt3rlWFS20n/yaOVEpOPRfp+hwperF9UJRQHEgWnOGBUgF+Px+uSnIRbHUW6L1G7GgZMM
        m3+ZB5TbzaVsDpnklREgaw9ME5sHgTZCMKxk7RI77BQtp
X-Received: by 2002:a0c:99c6:: with SMTP id y6mr1821420qve.86.1594386736001;
        Fri, 10 Jul 2020 06:12:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9RWPlwBIDqIqcIVeuPYc/yVHOL4Bv31pagG1xZd2bOFxAr0b6g9yU150qGVyBPTDD86cJ1Q==
X-Received: by 2002:a0c:99c6:: with SMTP id y6mr1821289qve.86.1594386734469;
        Fri, 10 Jul 2020 06:12:14 -0700 (PDT)
Received: from valinor ([2804:14c:4e6:18:5826:1328:7aa0:952c])
        by smtp.gmail.com with ESMTPSA id w18sm7381646qtn.3.2020.07.10.06.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:12:12 -0700 (PDT)
Date:   Fri, 10 Jul 2020 10:12:03 -0300
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, jmorris@namei.org, serge@hallyn.com,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com, vt@altlinux.org, gilad@benyossef.com,
        pvanleeuwen@rambus.com, zhang.jia@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 2/8] lib/mpi: Extend the MPI library
Message-ID: <20200710131203.wyj33bq2hgkz6pv4@valinor>
References: <20200709084015.21886-1-tianjia.zhang@linux.alibaba.com>
 <20200709084015.21886-3-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4mfzr6qn7hyblft7"
Content-Disposition: inline
In-Reply-To: <20200709084015.21886-3-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--4mfzr6qn7hyblft7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Tianjia.

On Thu, Jul 09, 2020 at 04:40:09PM +0800, Tianjia Zhang wrote:
> Expand the mpi library based on libgcrypt, and the ECC algorithm of
> mpi based on libgcrypt requires these functions.
> Some other algorithms will be developed based on mpi ecc, such as SM2.
>=20
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  include/linux/mpi.h    |  88 +++++++++++
>  lib/mpi/Makefile       |   5 +
>  lib/mpi/mpi-add.c      | 207 +++++++++++++++++++++++++
>  lib/mpi/mpi-bit.c      | 251 ++++++++++++++++++++++++++++++
>  lib/mpi/mpi-cmp.c      |  46 ++++--
>  lib/mpi/mpi-div.c      | 238 +++++++++++++++++++++++++++++
>  lib/mpi/mpi-internal.h |  53 +++++++
>  lib/mpi/mpi-inv.c      | 143 ++++++++++++++++++
>  lib/mpi/mpi-mod.c      | 155 +++++++++++++++++++
>  lib/mpi/mpi-mul.c      |  94 ++++++++++++
>  lib/mpi/mpicoder.c     | 336 +++++++++++++++++++++++++++++++++++++++++
>  lib/mpi/mpih-div.c     | 294 ++++++++++++++++++++++++++++++++++++
>  lib/mpi/mpih-mul.c     |  25 +++
>  lib/mpi/mpiutil.c      | 204 +++++++++++++++++++++++++
>  14 files changed, 2129 insertions(+), 10 deletions(-)
>  create mode 100644 lib/mpi/mpi-add.c
>  create mode 100644 lib/mpi/mpi-div.c
>  create mode 100644 lib/mpi/mpi-inv.c
>  create mode 100644 lib/mpi/mpi-mod.c
>  create mode 100644 lib/mpi/mpi-mul.c
>=20
> diff --git a/include/linux/mpi.h b/include/linux/mpi.h
> index 7bd6d8af0004..2dddf4c6e011 100644
> --- a/include/linux/mpi.h
> +++ b/include/linux/mpi.h
> @@ -40,21 +40,79 @@ struct gcry_mpi {
>  typedef struct gcry_mpi *MPI;
> =20
>  #define mpi_get_nlimbs(a)     ((a)->nlimbs)
> +#define mpi_has_sign(a)       ((a)->sign)
> =20
>  /*-- mpiutil.c --*/
>  MPI mpi_alloc(unsigned nlimbs);
> +void mpi_clear(MPI a);
>  void mpi_free(MPI a);
>  int mpi_resize(MPI a, unsigned nlimbs);
> =20
> +static inline MPI mpi_new(unsigned int nbits)
> +{
> +	return mpi_alloc((nbits + BITS_PER_MPI_LIMB - 1) / BITS_PER_MPI_LIMB);
> +}
> +
> +MPI mpi_copy(MPI a);
> +MPI mpi_alloc_like(MPI a);
> +void mpi_snatch(MPI w, MPI u);
> +MPI mpi_set(MPI w, MPI u);
> +MPI mpi_set_ui(MPI w, unsigned long u);
> +MPI mpi_alloc_set_ui(unsigned long u);
> +void mpi_swap_cond(MPI a, MPI b, unsigned long swap);
> +
> +/* Constants used to return constant MPIs.  See mpi_init if you
> + * want to add more constants.
> + */
> +#define MPI_NUMBER_OF_CONSTANTS 6
> +enum gcry_mpi_constants {
> +	MPI_C_ZERO,
> +	MPI_C_ONE,
> +	MPI_C_TWO,
> +	MPI_C_THREE,
> +	MPI_C_FOUR,
> +	MPI_C_EIGHT
> +};
> +
> +MPI mpi_const(enum gcry_mpi_constants no);
> +
>  /*-- mpicoder.c --*/
> +
> +/* Different formats of external big integer representation. */
> +enum gcry_mpi_format {
> +	GCRYMPI_FMT_NONE =3D 0,
> +	GCRYMPI_FMT_STD =3D 1,    /* Twos complement stored without length. */
> +	GCRYMPI_FMT_PGP =3D 2,    /* As used by OpenPGP (unsigned only). */
> +	GCRYMPI_FMT_SSH =3D 3,    /* As used by SSH (like STD but with length).=
 */
> +	GCRYMPI_FMT_HEX =3D 4,    /* Hex format. */
> +	GCRYMPI_FMT_USG =3D 5,    /* Like STD but unsigned. */
> +	GCRYMPI_FMT_OPAQUE =3D 8  /* Opaque format (some functions only). */
> +};
> +
>  MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes);
>  MPI mpi_read_from_buffer(const void *buffer, unsigned *ret_nread);
> +int mpi_fromstr(MPI val, const char *str);
> +MPI mpi_scanval(const char *string);
>  MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int len);
>  void *mpi_get_buffer(MPI a, unsigned *nbytes, int *sign);
>  int mpi_read_buffer(MPI a, uint8_t *buf, unsigned buf_len, unsigned *nby=
tes,
>  		    int *sign);
>  int mpi_write_to_sgl(MPI a, struct scatterlist *sg, unsigned nbytes,
>  		     int *sign);
> +int mpi_print(enum gcry_mpi_format format, unsigned char *buffer,
> +			size_t buflen, size_t *nwritten, MPI a);
> +
> +/*-- mpi-mod.c --*/
> +void mpi_mod(MPI rem, MPI dividend, MPI divisor);
> +
> +/* Context used with Barrett reduction.  */
> +struct barrett_ctx_s;
> +typedef struct barrett_ctx_s *mpi_barrett_t;
> +
> +mpi_barrett_t mpi_barrett_init(MPI m, int copy);
> +void mpi_barrett_free(mpi_barrett_t ctx);
> +void mpi_mod_barrett(MPI r, MPI x, mpi_barrett_t ctx);
> +void mpi_mul_barrett(MPI w, MPI u, MPI v, mpi_barrett_t ctx);
> =20
>  /*-- mpi-pow.c --*/
>  int mpi_powm(MPI res, MPI base, MPI exp, MPI mod);
> @@ -62,10 +120,40 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod);
>  /*-- mpi-cmp.c --*/
>  int mpi_cmp_ui(MPI u, ulong v);
>  int mpi_cmp(MPI u, MPI v);
> +int mpi_cmpabs(MPI u, MPI v);
> =20
>  /*-- mpi-bit.c --*/
>  void mpi_normalize(MPI a);
>  unsigned mpi_get_nbits(MPI a);
> +int mpi_test_bit(MPI a, unsigned int n);
> +void mpi_set_bit(MPI a, unsigned int n);
> +void mpi_set_highbit(MPI a, unsigned int n);
> +void mpi_clear_highbit(MPI a, unsigned int n);
> +void mpi_clear_bit(MPI a, unsigned int n);
> +void mpi_rshift_limbs(MPI a, unsigned int count);
> +void mpi_rshift(MPI x, MPI a, unsigned int n);
> +void mpi_lshift_limbs(MPI a, unsigned int count);
> +void mpi_lshift(MPI x, MPI a, unsigned int n);
> +
> +/*-- mpi-add.c --*/
> +void mpi_add_ui(MPI w, MPI u, unsigned long v);
> +void mpi_add(MPI w, MPI u, MPI v);
> +void mpi_sub_ui(MPI w, MPI u, unsigned long v);
> +void mpi_sub(MPI w, MPI u, MPI v);
> +void mpi_addm(MPI w, MPI u, MPI v, MPI m);
> +void mpi_subm(MPI w, MPI u, MPI v, MPI m);
> +
> +/*-- mpi-mul.c --*/
> +void mpi_mul(MPI w, MPI u, MPI v);
> +void mpi_mulm(MPI w, MPI u, MPI v, MPI m);
> +
> +/*-- mpi-div.c --*/
> +void mpi_tdiv_r(MPI rem, MPI num, MPI den);
> +void mpi_fdiv_r(MPI rem, MPI dividend, MPI divisor);
> +void mpi_fdiv_q(MPI quot, MPI dividend, MPI divisor);
> +
> +/*-- mpi-inv.c --*/
> +int mpi_invm(MPI x, MPI a, MPI n);
> =20
>  /* inline functions */
> =20
> diff --git a/lib/mpi/Makefile b/lib/mpi/Makefile
> index d5874a7f5ff9..5f40f93ff3d9 100644
> --- a/lib/mpi/Makefile
> +++ b/lib/mpi/Makefile
> @@ -14,8 +14,13 @@ mpi-y =3D \
>  	generic_mpih-sub1.o		\
>  	generic_mpih-add1.o		\
>  	mpicoder.o			\
> +	mpi-add.o			\
>  	mpi-bit.o			\
>  	mpi-cmp.o			\
> +	mpi-div.o			\
> +	mpi-inv.o			\
> +	mpi-mod.o			\
> +	mpi-mul.o			\
>  	mpih-cmp.o			\
>  	mpih-div.o			\
>  	mpih-mul.o			\
> diff --git a/lib/mpi/mpi-add.c b/lib/mpi/mpi-add.c
> new file mode 100644
> index 000000000000..9afad7832737
> --- /dev/null
> +++ b/lib/mpi/mpi-add.c
> @@ -0,0 +1,207 @@
> +/* mpi-add.c  -  MPI functions
> + * Copyright (C) 1994, 1996, 1998, 2001, 2002,
> + *               2003 Free Software Foundation, Inc.
> + *
> + * This file is part of Libgcrypt.
> + *
> + * Note: This code is heavily based on the GNU MP Library.
> + *	 Actually it's the same code with only minor changes in the
> + *	 way the data is stored; this is to support the abstraction
> + *	 of an optional secure memory allocation which may be used
> + *	 to avoid revealing of sensitive data due to paging etc.
> + */
> +
> +#include "mpi-internal.h"
> +
> +/****************
> + * Add the unsigned integer V to the mpi-integer U and store the
> + * result in W. U and V may be the same.
> + */
> +void mpi_add_ui(MPI w, MPI u, unsigned long v)
> +{
> +	mpi_ptr_t wp, up;
> +	mpi_size_t usize, wsize;
> +	int usign, wsign;
> +
> +	usize =3D u->nlimbs;
> +	usign =3D u->sign;
> +	wsign =3D 0;
> +
> +	/* If not space for W (and possible carry), increase space.  */
> +	wsize =3D usize + 1;
> +	if (w->alloced < wsize)
> +		mpi_resize(w, wsize);

You are ignoring the mpi_resize() return. I believe these new functions
need to return an int to indicate errors as mpi_powm() does.


> +
> +	/* These must be after realloc (U may be the same as W).  */
> +	up =3D u->d;
> +	wp =3D w->d;
> +
> +	if (!usize) {  /* simple */
> +		wp[0] =3D v;
> +		wsize =3D v ? 1:0;
> +	} else if (!usign) {  /* mpi is not negative */
> +		mpi_limb_t cy;
> +		cy =3D mpihelp_add_1(wp, up, usize, v);
> +		wp[usize] =3D cy;
> +		wsize =3D usize + cy;
> +	} else {
> +		/* The signs are different.  Need exact comparison to determine
> +		 * which operand to subtract from which.
> +		 */
> +		if (usize =3D=3D 1 && up[0] < v) {
> +			wp[0] =3D v - up[0];
> +			wsize =3D 1;
> +		} else {
> +			mpihelp_sub_1(wp, up, usize, v);
> +			/* Size can decrease with at most one limb. */
> +			wsize =3D usize - (wp[usize-1] =3D=3D 0);
> +			wsign =3D 1;
> +		}
> +	}
> +
> +	w->nlimbs =3D wsize;
> +	w->sign   =3D wsign;
> +}
> +
> +
> +void mpi_add(MPI w, MPI u, MPI v)
> +{
> +	mpi_ptr_t wp, up, vp;
> +	mpi_size_t usize, vsize, wsize;
> +	int usign, vsign, wsign;
> +
> +	if (u->nlimbs < v->nlimbs) { /* Swap U and V. */
> +		usize =3D v->nlimbs;
> +		usign =3D v->sign;
> +		vsize =3D u->nlimbs;
> +		vsign =3D u->sign;
> +		wsize =3D usize + 1;
> +		RESIZE_IF_NEEDED(w, wsize);
> +		/* These must be after realloc (u or v may be the same as w).  */
> +		up =3D v->d;
> +		vp =3D u->d;
> +	} else {
> +		usize =3D u->nlimbs;
> +		usign =3D u->sign;
> +		vsize =3D v->nlimbs;
> +		vsign =3D v->sign;
> +		wsize =3D usize + 1;
> +		RESIZE_IF_NEEDED(w, wsize);
> +		/* These must be after realloc (u or v may be the same as w).  */
> +		up =3D u->d;
> +		vp =3D v->d;
> +	}
> +	wp =3D w->d;
> +	wsign =3D 0;
> +
> +	if (!vsize) {  /* simple */
> +		MPN_COPY(wp, up, usize);
> +		wsize =3D usize;
> +		wsign =3D usign;
> +	} else if (usign !=3D vsign) { /* different sign */
> +		/* This test is right since USIZE >=3D VSIZE */
> +		if (usize !=3D vsize) {
> +			mpihelp_sub(wp, up, usize, vp, vsize);
> +			wsize =3D usize;
> +			MPN_NORMALIZE(wp, wsize);
> +			wsign =3D usign;
> +		} else if (mpihelp_cmp(up, vp, usize) < 0) {
> +			mpihelp_sub_n(wp, vp, up, usize);
> +			wsize =3D usize;
> +			MPN_NORMALIZE(wp, wsize);
> +			if (!usign)
> +				wsign =3D 1;
> +		} else {
> +			mpihelp_sub_n(wp, up, vp, usize);
> +			wsize =3D usize;
> +			MPN_NORMALIZE(wp, wsize);
> +			if (usign)
> +				wsign =3D 1;
> +		}
> +	} else { /* U and V have same sign. Add them. */
> +		mpi_limb_t cy =3D mpihelp_add(wp, up, usize, vp, vsize);
> +		wp[usize] =3D cy;
> +		wsize =3D usize + cy;
> +		if (usign)
> +			wsign =3D 1;
> +	}
> +
> +	w->nlimbs =3D wsize;
> +	w->sign =3D wsign;
> +}
> +EXPORT_SYMBOL_GPL(mpi_add);
> +
> +
> +/****************
> + * Subtract the unsigned integer V from the mpi-integer U and store the
> + * result in W.
> + */
> +void mpi_sub_ui(MPI w, MPI u, unsigned long v)
> +{
> +	mpi_ptr_t wp, up;
> +	mpi_size_t usize, wsize;
> +	int usign, wsign;
> +
> +	usize =3D u->nlimbs;
> +	usign =3D u->sign;
> +	wsign =3D 0;
> +
> +	/* If not space for W (and possible carry), increase space.  */
> +	wsize =3D usize + 1;
> +	if (w->alloced < wsize)
> +		mpi_resize(w, wsize);
> +
> +	/* These must be after realloc (U may be the same as W).  */
> +	up =3D u->d;
> +	wp =3D w->d;
> +
> +	if (!usize) {  /* simple */
> +		wp[0] =3D v;
> +		wsize =3D v ? 1:0;
> +		wsign =3D 1;
> +	} else if (usign) {	/* mpi and v are negative */
> +		mpi_limb_t cy;
> +		cy =3D mpihelp_add_1(wp, up, usize, v);
> +		wp[usize] =3D cy;
> +		wsize =3D usize + cy;
> +	} else {
> +		/* The signs are different.  Need exact comparison to determine
> +		 * which operand to subtract from which.
> +		 */
> +		if (usize =3D=3D 1 && up[0] < v) {
> +			wp[0] =3D v - up[0];
> +			wsize =3D 1;
> +			wsign =3D 1;
> +		} else {
> +			mpihelp_sub_1(wp, up, usize, v);
> +			/* Size can decrease with at most one limb. */
> +			wsize =3D usize - (wp[usize-1] =3D=3D 0);
> +		}
> +	}
> +
> +	w->nlimbs =3D wsize;
> +	w->sign   =3D wsign;
> +}
> +
> +void mpi_sub(MPI w, MPI u, MPI v)
> +{
> +	MPI vv =3D mpi_copy(v);
> +	vv->sign =3D !vv->sign;
> +	mpi_add(w, u, vv);
> +	mpi_free(vv);
> +}
> +
> +
> +void mpi_addm(MPI w, MPI u, MPI v, MPI m)
> +{
> +	mpi_add(w, u, v);
> +	mpi_mod(w, w, m);
> +}
> +EXPORT_SYMBOL_GPL(mpi_addm);
> +
> +void mpi_subm(MPI w, MPI u, MPI v, MPI m)
> +{
> +	mpi_sub(w, u, v);
> +	mpi_mod(w, w, m);
> +}
> +EXPORT_SYMBOL_GPL(mpi_subm);
> diff --git a/lib/mpi/mpi-bit.c b/lib/mpi/mpi-bit.c
> index 503537e08436..a5119a2bcdd4 100644
> --- a/lib/mpi/mpi-bit.c
> +++ b/lib/mpi/mpi-bit.c
> @@ -32,6 +32,7 @@ void mpi_normalize(MPI a)
>  	for (; a->nlimbs && !a->d[a->nlimbs - 1]; a->nlimbs--)
>  		;
>  }
> +EXPORT_SYMBOL_GPL(mpi_normalize);
> =20
>  /****************
>   * Return the number of bits in A.
> @@ -54,3 +55,253 @@ unsigned mpi_get_nbits(MPI a)
>  	return n;
>  }
>  EXPORT_SYMBOL_GPL(mpi_get_nbits);
> +
> +/****************
> + * Test whether bit N is set.
> + */
> +int mpi_test_bit(MPI a, unsigned int n)
> +{
> +	unsigned int limbno, bitno;
> +	mpi_limb_t limb;
> +
> +	limbno =3D n / BITS_PER_MPI_LIMB;
> +	bitno  =3D n % BITS_PER_MPI_LIMB;
> +
> +	if (limbno >=3D a->nlimbs)
> +		return 0; /* too far left: this is a 0 */
> +	limb =3D a->d[limbno];
> +	return (limb & (A_LIMB_1 << bitno)) ? 1 : 0;
> +}
> +EXPORT_SYMBOL_GPL(mpi_test_bit);
> +
> +/****************
> + * Set bit N of A.
> + */
> +void mpi_set_bit(MPI a, unsigned int n)
> +{
> +	unsigned int i, limbno, bitno;
> +
> +	limbno =3D n / BITS_PER_MPI_LIMB;
> +	bitno  =3D n % BITS_PER_MPI_LIMB;
> +
> +	if (limbno >=3D a->nlimbs) {
> +		for (i =3D a->nlimbs; i < a->alloced; i++)
> +			a->d[i] =3D 0;
> +		mpi_resize(a, limbno+1);
> +		a->nlimbs =3D limbno+1;
> +	}
> +	a->d[limbno] |=3D (A_LIMB_1<<bitno);
> +}
> +
> +/****************
> + * Set bit N of A. and clear all bits above
> + */
> +void mpi_set_highbit(MPI a, unsigned int n)
> +{
> +	unsigned int i, limbno, bitno;
> +
> +	limbno =3D n / BITS_PER_MPI_LIMB;
> +	bitno  =3D n % BITS_PER_MPI_LIMB;
> +
> +	if (limbno >=3D a->nlimbs) {
> +		for (i =3D a->nlimbs; i < a->alloced; i++)
> +			a->d[i] =3D 0;
> +		mpi_resize(a, limbno+1);
> +		a->nlimbs =3D limbno+1;
> +	}
> +	a->d[limbno] |=3D (A_LIMB_1<<bitno);
> +	for (bitno++; bitno < BITS_PER_MPI_LIMB; bitno++)
> +		a->d[limbno] &=3D ~(A_LIMB_1 << bitno);
> +	a->nlimbs =3D limbno+1;
> +}
> +EXPORT_SYMBOL_GPL(mpi_set_highbit);
> +
> +/****************
> + * clear bit N of A and all bits above
> + */
> +void mpi_clear_highbit(MPI a, unsigned int n)
> +{
> +	unsigned int limbno, bitno;
> +
> +	limbno =3D n / BITS_PER_MPI_LIMB;
> +	bitno  =3D n % BITS_PER_MPI_LIMB;
> +
> +	if (limbno >=3D a->nlimbs)
> +		return; /* not allocated, therefore no need to clear bits :-) */
> +
> +	for ( ; bitno < BITS_PER_MPI_LIMB; bitno++)
> +		a->d[limbno] &=3D ~(A_LIMB_1 << bitno);
> +	a->nlimbs =3D limbno+1;
> +}
> +
> +/****************
> + * Clear bit N of A.
> + */
> +void mpi_clear_bit(MPI a, unsigned int n)
> +{
> +	unsigned int limbno, bitno;
> +
> +	limbno =3D n / BITS_PER_MPI_LIMB;
> +	bitno  =3D n % BITS_PER_MPI_LIMB;
> +
> +	if (limbno >=3D a->nlimbs)
> +		return; /* Don't need to clear this bit, it's far too left.  */
> +	a->d[limbno] &=3D ~(A_LIMB_1 << bitno);
> +}
> +EXPORT_SYMBOL_GPL(mpi_clear_bit);
> +
> +
> +/****************
> + * Shift A by COUNT limbs to the right
> + * This is used only within the MPI library
> + */
> +void mpi_rshift_limbs(MPI a, unsigned int count)
> +{
> +	mpi_ptr_t ap =3D a->d;
> +	mpi_size_t n =3D a->nlimbs;
> +	unsigned int i;
> +
> +	if (count >=3D n) {
> +		a->nlimbs =3D 0;
> +		return;
> +	}
> +
> +	for (i =3D 0; i < n - count; i++)
> +		ap[i] =3D ap[i+count];
> +	ap[i] =3D 0;
> +	a->nlimbs -=3D count;
> +}
> +
> +/*
> + * Shift A by N bits to the right.
> + */
> +void mpi_rshift(MPI x, MPI a, unsigned int n)
> +{
> +	mpi_size_t xsize;
> +	unsigned int i;
> +	unsigned int nlimbs =3D (n/BITS_PER_MPI_LIMB);
> +	unsigned int nbits =3D (n%BITS_PER_MPI_LIMB);
> +
> +	if (x =3D=3D a) {
> +		/* In-place operation.  */
> +		if (nlimbs >=3D x->nlimbs) {
> +			x->nlimbs =3D 0;
> +			return;
> +		}
> +
> +		if (nlimbs) {
> +			for (i =3D 0; i < x->nlimbs - nlimbs; i++)
> +				x->d[i] =3D x->d[i+nlimbs];
> +			x->d[i] =3D 0;
> +			x->nlimbs -=3D nlimbs;
> +		}
> +		if (x->nlimbs && nbits)
> +			mpihelp_rshift(x->d, x->d, x->nlimbs, nbits);
> +	} else if (nlimbs) {
> +		/* Copy and shift by more or equal bits than in a limb. */
> +		xsize =3D a->nlimbs;
> +		x->sign =3D a->sign;
> +		RESIZE_IF_NEEDED(x, xsize);
> +		x->nlimbs =3D xsize;
> +		for (i =3D 0; i < a->nlimbs; i++)
> +			x->d[i] =3D a->d[i];
> +		x->nlimbs =3D i;
> +
> +		if (nlimbs >=3D x->nlimbs) {
> +			x->nlimbs =3D 0;
> +			return;
> +		}
> +
> +		if (nlimbs) {
> +			for (i =3D 0; i < x->nlimbs - nlimbs; i++)
> +				x->d[i] =3D x->d[i+nlimbs];
> +			x->d[i] =3D 0;
> +			x->nlimbs -=3D nlimbs;
> +		}
> +
> +		if (x->nlimbs && nbits)
> +			mpihelp_rshift(x->d, x->d, x->nlimbs, nbits);
> +	} else {
> +		/* Copy and shift by less than bits in a limb.  */
> +		xsize =3D a->nlimbs;
> +		x->sign =3D a->sign;
> +		RESIZE_IF_NEEDED(x, xsize);
> +		x->nlimbs =3D xsize;
> +
> +		if (xsize) {
> +			if (nbits)
> +				mpihelp_rshift(x->d, a->d, x->nlimbs, nbits);
> +			else {
> +				/* The rshift helper function is not specified for
> +				 * NBITS=3D=3D0, thus we do a plain copy here.
> +				 */
> +				for (i =3D 0; i < x->nlimbs; i++)
> +					x->d[i] =3D a->d[i];
> +			}
> +		}
> +	}
> +	MPN_NORMALIZE(x->d, x->nlimbs);
> +}
> +
> +/****************
> + * Shift A by COUNT limbs to the left
> + * This is used only within the MPI library
> + */
> +void mpi_lshift_limbs(MPI a, unsigned int count)
> +{
> +	mpi_ptr_t ap;
> +	int n =3D a->nlimbs;
> +	int i;
> +
> +	if (!count || !n)
> +		return;
> +
> +	RESIZE_IF_NEEDED(a, n+count);
> +
> +	ap =3D a->d;
> +	for (i =3D n-1; i >=3D 0; i--)
> +		ap[i+count] =3D ap[i];
> +	for (i =3D 0; i < count; i++)
> +		ap[i] =3D 0;
> +	a->nlimbs +=3D count;
> +}
> +
> +/*
> + * Shift A by N bits to the left.
> + */
> +void mpi_lshift(MPI x, MPI a, unsigned int n)
> +{
> +	unsigned int nlimbs =3D (n/BITS_PER_MPI_LIMB);
> +	unsigned int nbits =3D (n%BITS_PER_MPI_LIMB);
> +
> +	if (x =3D=3D a && !n)
> +		return;  /* In-place shift with an amount of zero.  */
> +
> +	if (x !=3D a) {
> +		/* Copy A to X.  */
> +		unsigned int alimbs =3D a->nlimbs;
> +		int asign =3D a->sign;
> +		mpi_ptr_t xp, ap;
> +
> +		RESIZE_IF_NEEDED(x, alimbs+nlimbs+1);
> +		xp =3D x->d;
> +		ap =3D a->d;
> +		MPN_COPY(xp, ap, alimbs);
> +		x->nlimbs =3D alimbs;
> +		x->flags =3D a->flags;
> +		x->sign =3D asign;
> +	}
> +
> +	if (nlimbs && !nbits) {
> +		/* Shift a full number of limbs.  */
> +		mpi_lshift_limbs(x, nlimbs);
> +	} else if (n) {
> +		/* We use a very dump approach: Shift left by the number of
> +		 * limbs plus one and than fix it up by an rshift.
> +		 */
> +		mpi_lshift_limbs(x, nlimbs+1);
> +		mpi_rshift(x, x, BITS_PER_MPI_LIMB - nbits);
> +	}
> +
> +	MPN_NORMALIZE(x->d, x->nlimbs);
> +}
> diff --git a/lib/mpi/mpi-cmp.c b/lib/mpi/mpi-cmp.c
> index d25e9e96c310..c4cfa3ff0581 100644
> --- a/lib/mpi/mpi-cmp.c
> +++ b/lib/mpi/mpi-cmp.c
> @@ -41,28 +41,54 @@ int mpi_cmp_ui(MPI u, unsigned long v)
>  }
>  EXPORT_SYMBOL_GPL(mpi_cmp_ui);
> =20
> -int mpi_cmp(MPI u, MPI v)
> +static int do_mpi_cmp(MPI u, MPI v, int absmode)
>  {
> -	mpi_size_t usize, vsize;
> +	mpi_size_t usize;
> +	mpi_size_t vsize;
> +	int usign;
> +	int vsign;
>  	int cmp;
> =20
>  	mpi_normalize(u);
>  	mpi_normalize(v);
> +
>  	usize =3D u->nlimbs;
>  	vsize =3D v->nlimbs;
> -	if (!u->sign && v->sign)
> +	usign =3D absmode ? 0 : u->sign;
> +	vsign =3D absmode ? 0 : v->sign;
> +
> +	/* Compare sign bits.  */
> +
> +	if (!usign && vsign)
>  		return 1;
> -	if (u->sign && !v->sign)
> +	if (usign && !vsign)
>  		return -1;
> -	if (usize !=3D vsize && !u->sign && !v->sign)
> +
> +	/* U and V are either both positive or both negative.  */
> +
> +	if (usize !=3D vsize && !usign && !vsign)
>  		return usize - vsize;
> -	if (usize !=3D vsize && u->sign && v->sign)
> -		return vsize - usize;
> +	if (usize !=3D vsize && usign && vsign)
> +		return vsize + usize;
>  	if (!usize)
>  		return 0;
>  	cmp =3D mpihelp_cmp(u->d, v->d, usize);
> -	if (u->sign)
> -		return -cmp;
> -	return cmp;
> +	if (!cmp)
> +		return 0;
> +	if ((cmp < 0?1:0) =3D=3D (usign?1:0))
> +		return 1;
> +
> +	return -1;
> +}
> +
> +int mpi_cmp(MPI u, MPI v)
> +{
> +	return do_mpi_cmp(u, v, 0);
>  }
>  EXPORT_SYMBOL_GPL(mpi_cmp);
> +
> +int mpi_cmpabs(MPI u, MPI v)
> +{
> +	return do_mpi_cmp(u, v, 1);
> +}
> +EXPORT_SYMBOL_GPL(mpi_cmpabs);
> diff --git a/lib/mpi/mpi-div.c b/lib/mpi/mpi-div.c
> new file mode 100644
> index 000000000000..21332dab97d4
> --- /dev/null
> +++ b/lib/mpi/mpi-div.c
> @@ -0,0 +1,238 @@
> +/* mpi-div.c  -  MPI functions
> + * Copyright (C) 1994, 1996, 1998, 2001, 2002,
> + *               2003 Free Software Foundation, Inc.
> + *
> + * This file is part of Libgcrypt.
> + *
> + * Note: This code is heavily based on the GNU MP Library.
> + *	 Actually it's the same code with only minor changes in the
> + *	 way the data is stored; this is to support the abstraction
> + *	 of an optional secure memory allocation which may be used
> + *	 to avoid revealing of sensitive data due to paging etc.
> + */
> +
> +#include "mpi-internal.h"
> +#include "longlong.h"
> +
> +void mpi_tdiv_qr(MPI quot, MPI rem, MPI num, MPI den);
> +void mpi_fdiv_qr(MPI quot, MPI rem, MPI dividend, MPI divisor);
> +
> +void mpi_fdiv_r(MPI rem, MPI dividend, MPI divisor)
> +{
> +	int divisor_sign =3D divisor->sign;
> +	MPI temp_divisor =3D NULL;
> +
> +	/* We need the original value of the divisor after the remainder has be=
en
> +	 * preliminary calculated.	We have to copy it to temporary space if it's
> +	 * the same variable as REM.
> +	 */
> +	if (rem =3D=3D divisor) {
> +		temp_divisor =3D mpi_copy(divisor);
> +		divisor =3D temp_divisor;
> +	}
> +
> +	mpi_tdiv_r(rem, dividend, divisor);
> +
> +	if (((divisor_sign?1:0) ^ (dividend->sign?1:0)) && rem->nlimbs)
> +		mpi_add(rem, rem, divisor);
> +
> +	if (temp_divisor)
> +		mpi_free(temp_divisor);
> +}
> +
> +void mpi_fdiv_q(MPI quot, MPI dividend, MPI divisor)
> +{
> +	MPI tmp =3D mpi_alloc(mpi_get_nlimbs(quot));
> +	mpi_fdiv_qr(quot, tmp, dividend, divisor);
> +	mpi_free(tmp);
> +}
> +
> +void mpi_fdiv_qr(MPI quot, MPI rem, MPI dividend, MPI divisor)
> +{
> +	int divisor_sign =3D divisor->sign;
> +	MPI temp_divisor =3D NULL;
> +
> +	if (quot =3D=3D divisor || rem =3D=3D divisor) {
> +		temp_divisor =3D mpi_copy(divisor);
> +		divisor =3D temp_divisor;
> +	}
> +
> +	mpi_tdiv_qr(quot, rem, dividend, divisor);
> +
> +	if ((divisor_sign ^ dividend->sign) && rem->nlimbs) {
> +		mpi_sub_ui(quot, quot, 1);
> +		mpi_add(rem, rem, divisor);
> +	}
> +
> +	if (temp_divisor)
> +		mpi_free(temp_divisor);
> +}
> +
> +/* If den =3D=3D quot, den needs temporary storage.
> + * If den =3D=3D rem, den needs temporary storage.
> + * If num =3D=3D quot, num needs temporary storage.
> + * If den has temporary storage, it can be normalized while being copied,
> + *   i.e no extra storage should be allocated.
> + */
> +
> +void mpi_tdiv_r(MPI rem, MPI num, MPI den)
> +{
> +	mpi_tdiv_qr(NULL, rem, num, den);
> +}
> +
> +void mpi_tdiv_qr(MPI quot, MPI rem, MPI num, MPI den)
> +{
> +	mpi_ptr_t np, dp;
> +	mpi_ptr_t qp, rp;
> +	mpi_size_t nsize =3D num->nlimbs;
> +	mpi_size_t dsize =3D den->nlimbs;
> +	mpi_size_t qsize, rsize;
> +	mpi_size_t sign_remainder =3D num->sign;
> +	mpi_size_t sign_quotient =3D num->sign ^ den->sign;
> +	unsigned int normalization_steps;
> +	mpi_limb_t q_limb;
> +	mpi_ptr_t marker[5];
> +	unsigned int marker_nlimbs[5];
> +	int markidx =3D 0;
> +
> +	/* Ensure space is enough for quotient and remainder.
> +	 * We need space for an extra limb in the remainder, because it's
> +	 * up-shifted (normalized) below.
> +	 */
> +	rsize =3D nsize + 1;
> +	mpi_resize(rem, rsize);
> +
> +	qsize =3D rsize - dsize;	  /* qsize cannot be bigger than this.	*/
> +	if (qsize <=3D 0) {
> +		if (num !=3D rem) {
> +			rem->nlimbs =3D num->nlimbs;
> +			rem->sign =3D num->sign;
> +			MPN_COPY(rem->d, num->d, nsize);
> +		}
> +		if (quot) {
> +			/* This needs to follow the assignment to rem, in case the
> +			 * numerator and quotient are the same.
> +			 */
> +			quot->nlimbs =3D 0;
> +			quot->sign =3D 0;
> +		}
> +		return;
> +	}
> +
> +	if (quot)
> +		mpi_resize(quot, qsize);
> +
> +	/* Read pointers here, when reallocation is finished.  */
> +	np =3D num->d;
> +	dp =3D den->d;
> +	rp =3D rem->d;
> +
> +	/* Optimize division by a single-limb divisor.  */
> +	if (dsize =3D=3D 1) {
> +		mpi_limb_t rlimb;
> +		if (quot) {
> +			qp =3D quot->d;
> +			rlimb =3D mpihelp_divmod_1(qp, np, nsize, dp[0]);
> +			qsize -=3D qp[qsize - 1] =3D=3D 0;
> +			quot->nlimbs =3D qsize;
> +			quot->sign =3D sign_quotient;
> +		} else
> +			rlimb =3D mpihelp_mod_1(np, nsize, dp[0]);
> +		rp[0] =3D rlimb;
> +		rsize =3D rlimb !=3D 0?1:0;
> +		rem->nlimbs =3D rsize;
> +		rem->sign =3D sign_remainder;
> +		return;
> +	}
> +
> +
> +	if (quot) {
> +		qp =3D quot->d;
> +		/* Make sure QP and NP point to different objects.  Otherwise the
> +		 * numerator would be gradually overwritten by the quotient limbs.
> +		 */
> +		if (qp =3D=3D np) { /* Copy NP object to temporary space.  */
> +			marker_nlimbs[markidx] =3D nsize;
> +			np =3D marker[markidx++] =3D mpi_alloc_limb_space(nsize);
> +			MPN_COPY(np, qp, nsize);
> +		}
> +	} else /* Put quotient at top of remainder. */
> +		qp =3D rp + dsize;
> +
> +	normalization_steps =3D count_leading_zeros(dp[dsize - 1]);
> +
> +	/* Normalize the denominator, i.e. make its most significant bit set by
> +	 * shifting it NORMALIZATION_STEPS bits to the left.  Also shift the
> +	 * numerator the same number of steps (to keep the quotient the same!).
> +	 */
> +	if (normalization_steps) {
> +		mpi_ptr_t tp;
> +		mpi_limb_t nlimb;
> +
> +		/* Shift up the denominator setting the most significant bit of
> +		 * the most significant word.  Use temporary storage not to clobber
> +		 * the original contents of the denominator.
> +		 */
> +		marker_nlimbs[markidx] =3D dsize;
> +		tp =3D marker[markidx++] =3D mpi_alloc_limb_space(dsize);
> +		mpihelp_lshift(tp, dp, dsize, normalization_steps);
> +		dp =3D tp;
> +
> +		/* Shift up the numerator, possibly introducing a new most
> +		 * significant word.  Move the shifted numerator in the remainder
> +		 * meanwhile.
> +		 */
> +		nlimb =3D mpihelp_lshift(rp, np, nsize, normalization_steps);
> +		if (nlimb) {
> +			rp[nsize] =3D nlimb;
> +			rsize =3D nsize + 1;
> +		} else
> +			rsize =3D nsize;
> +	} else {
> +		/* The denominator is already normalized, as required.	Copy it to
> +		 * temporary space if it overlaps with the quotient or remainder.
> +		 */
> +		if (dp =3D=3D rp || (quot && (dp =3D=3D qp))) {
> +			mpi_ptr_t tp;
> +
> +			marker_nlimbs[markidx] =3D dsize;
> +			tp =3D marker[markidx++] =3D mpi_alloc_limb_space(dsize);
> +			MPN_COPY(tp, dp, dsize);
> +			dp =3D tp;
> +		}
> +
> +		/* Move the numerator to the remainder.  */
> +		if (rp !=3D np)
> +			MPN_COPY(rp, np, nsize);
> +
> +		rsize =3D nsize;
> +	}
> +
> +	q_limb =3D mpihelp_divrem(qp, 0, rp, rsize, dp, dsize);
> +
> +	if (quot) {
> +		qsize =3D rsize - dsize;
> +		if (q_limb) {
> +			qp[qsize] =3D q_limb;
> +			qsize +=3D 1;
> +		}
> +
> +		quot->nlimbs =3D qsize;
> +		quot->sign =3D sign_quotient;
> +	}
> +
> +	rsize =3D dsize;
> +	MPN_NORMALIZE(rp, rsize);
> +
> +	if (normalization_steps && rsize) {
> +		mpihelp_rshift(rp, rp, rsize, normalization_steps);
> +		rsize -=3D rp[rsize - 1] =3D=3D 0?1:0;
> +	}
> +
> +	rem->nlimbs =3D rsize;
> +	rem->sign	=3D sign_remainder;
> +	while (markidx) {
> +		markidx--;
> +		mpi_free_limb_space(marker[markidx]);
> +	}
> +}
> diff --git a/lib/mpi/mpi-internal.h b/lib/mpi/mpi-internal.h
> index 91df5f0b70f2..d29c4537c3a3 100644
> --- a/lib/mpi/mpi-internal.h
> +++ b/lib/mpi/mpi-internal.h
> @@ -52,6 +52,12 @@
>  typedef mpi_limb_t *mpi_ptr_t;	/* pointer to a limb */
>  typedef int mpi_size_t;		/* (must be a signed type) */
> =20
> +#define RESIZE_IF_NEEDED(a, b)			\
> +	do {					\
> +		if ((a)->alloced < (b))		\
> +			mpi_resize((a), (b));	\
> +	} while (0)
> +
>  /* Copy N limbs from S to D.  */
>  #define MPN_COPY(d, s, n) \
>  	do {					\
> @@ -60,6 +66,14 @@ typedef int mpi_size_t;		/* (must be a signed type) */
>  			(d)[_i] =3D (s)[_i];	\
>  	} while (0)
> =20
> +#define MPN_COPY_INCR(d, s, n)		\
> +	do {					\
> +		mpi_size_t _i;			\
> +		for (_i =3D 0; _i < (n); _i++)	\
> +			(d)[_i] =3D (s)[_i];	\
> +	} while (0)
> +
> +
>  #define MPN_COPY_DECR(d, s, n) \
>  	do {					\
>  		mpi_size_t _i;			\
> @@ -92,6 +106,38 @@ typedef int mpi_size_t;		/* (must be a signed type) */
>  			mul_n(prodp, up, vp, size, tspace);	\
>  	} while (0);
> =20
> +/* Divide the two-limb number in (NH,,NL) by D, with DI being the largest
> + * limb not larger than (2**(2*BITS_PER_MP_LIMB))/D - (2**BITS_PER_MP_LI=
MB).
> + * If this would yield overflow, DI should be the largest possible number
> + * (i.e., only ones).  For correct operation, the most significant bit o=
f D
> + * has to be set.  Put the quotient in Q and the remainder in R.
> + */
> +#define UDIV_QRNND_PREINV(q, r, nh, nl, d, di)				\
> +	do {								\
> +		mpi_limb_t _ql;						\
> +		mpi_limb_t _q, _r;					\
> +		mpi_limb_t _xh, _xl;					\
> +		umul_ppmm(_q, _ql, (nh), (di));				\
> +		_q +=3D (nh);	/* DI is 2**BITS_PER_MPI_LIMB too small */ \
> +		umul_ppmm(_xh, _xl, _q, (d));				\
> +		sub_ddmmss(_xh, _r, (nh), (nl), _xh, _xl);		\
> +		if (_xh) {						\
> +			sub_ddmmss(_xh, _r, _xh, _r, 0, (d));		\
> +			_q++;						\
> +			if (_xh) {					\
> +				sub_ddmmss(_xh, _r, _xh, _r, 0, (d));	\
> +				_q++;					\
> +			}						\
> +		}							\
> +		if (_r >=3D (d)) {					\
> +			_r -=3D (d);					\
> +			_q++;						\
> +		}							\
> +		(r) =3D _r;						\
> +		(q) =3D _q;						\
> +	} while (0)
> +
> +
>  /*-- mpiutil.c --*/
>  mpi_ptr_t mpi_alloc_limb_space(unsigned nlimbs);
>  void mpi_free_limb_space(mpi_ptr_t a);
> @@ -135,6 +181,8 @@ int mpihelp_mul(mpi_ptr_t prodp, mpi_ptr_t up, mpi_si=
ze_t usize,
>  void mpih_sqr_n_basecase(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t size);
>  void mpih_sqr_n(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t size,
>  		mpi_ptr_t tspace);
> +void mpihelp_mul_n(mpi_ptr_t prodp,
> +		mpi_ptr_t up, mpi_ptr_t vp, mpi_size_t size);
> =20
>  int mpihelp_mul_karatsuba_case(mpi_ptr_t prodp,
>  			       mpi_ptr_t up, mpi_size_t usize,
> @@ -146,9 +194,14 @@ mpi_limb_t mpihelp_mul_1(mpi_ptr_t res_ptr, mpi_ptr_=
t s1_ptr,
>  			 mpi_size_t s1_size, mpi_limb_t s2_limb);
> =20
>  /*-- mpih-div.c --*/
> +mpi_limb_t mpihelp_mod_1(mpi_ptr_t dividend_ptr, mpi_size_t dividend_siz=
e,
> +			 mpi_limb_t divisor_limb);
>  mpi_limb_t mpihelp_divrem(mpi_ptr_t qp, mpi_size_t qextra_limbs,
>  			  mpi_ptr_t np, mpi_size_t nsize,
>  			  mpi_ptr_t dp, mpi_size_t dsize);
> +mpi_limb_t mpihelp_divmod_1(mpi_ptr_t quot_ptr,
> +			    mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
> +			    mpi_limb_t divisor_limb);
> =20
>  /*-- generic_mpih-[lr]shift.c --*/
>  mpi_limb_t mpihelp_lshift(mpi_ptr_t wp, mpi_ptr_t up, mpi_size_t usize,
> diff --git a/lib/mpi/mpi-inv.c b/lib/mpi/mpi-inv.c
> new file mode 100644
> index 000000000000..61e37d18f793
> --- /dev/null
> +++ b/lib/mpi/mpi-inv.c
> @@ -0,0 +1,143 @@
> +/* mpi-inv.c  -  MPI functions
> + *	Copyright (C) 1998, 2001, 2002, 2003 Free Software Foundation, Inc.
> + *
> + * This file is part of Libgcrypt.
> + *
> + * Libgcrypt is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU Lesser General Public License as
> + * published by the Free Software Foundation; either version 2.1 of
> + * the License, or (at your option) any later version.
> + *
> + * Libgcrypt is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this program; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#include "mpi-internal.h"
> +
> +/****************
> + * Calculate the multiplicative inverse X of A mod N
> + * That is: Find the solution x for
> + *		1 =3D (a*x) mod n
> + */
> +int mpi_invm(MPI x, MPI a, MPI n)
> +{
> +	/* Extended Euclid's algorithm (See TAOCP Vol II, 4.5.2, Alg X)
> +	 * modified according to Michael Penk's solution for Exercise 35
> +	 * with further enhancement
> +	 */
> +	MPI u, v, u1, u2 =3D NULL, u3, v1, v2 =3D NULL, v3, t1, t2 =3D NULL, t3;
> +	unsigned int k;
> +	int sign;
> +	int odd;
> +
> +	if (!mpi_cmp_ui(a, 0))
> +		return 0; /* Inverse does not exists.  */
> +	if (!mpi_cmp_ui(n, 1))
> +		return 0; /* Inverse does not exists.  */
> +
> +	u =3D mpi_copy(a);
> +	v =3D mpi_copy(n);
> +
> +	for (k =3D 0; !mpi_test_bit(u, 0) && !mpi_test_bit(v, 0); k++) {
> +		mpi_rshift(u, u, 1);
> +		mpi_rshift(v, v, 1);
> +	}
> +	odd =3D mpi_test_bit(v, 0);
> +
> +	u1 =3D mpi_alloc_set_ui(1);
> +	if (!odd)
> +		u2 =3D mpi_alloc_set_ui(0);
> +	u3 =3D mpi_copy(u);
> +	v1 =3D mpi_copy(v);
> +	if (!odd) {
> +		v2 =3D mpi_alloc(mpi_get_nlimbs(u));
> +		mpi_sub(v2, u1, u); /* U is used as const 1 */
> +	}
> +	v3 =3D mpi_copy(v);
> +	if (mpi_test_bit(u, 0)) { /* u is odd */
> +		t1 =3D mpi_alloc_set_ui(0);
> +		if (!odd) {
> +			t2 =3D mpi_alloc_set_ui(1);
> +			t2->sign =3D 1;
> +		}
> +		t3 =3D mpi_copy(v);
> +		t3->sign =3D !t3->sign;
> +		goto Y4;
> +	} else {
> +		t1 =3D mpi_alloc_set_ui(1);
> +		if (!odd)
> +			t2 =3D mpi_alloc_set_ui(0);
> +		t3 =3D mpi_copy(u);
> +	}
> +
> +	do {
> +		do {
> +			if (!odd) {
> +				if (mpi_test_bit(t1, 0) || mpi_test_bit(t2, 0)) {
> +					/* one is odd */
> +					mpi_add(t1, t1, v);
> +					mpi_sub(t2, t2, u);
> +				}
> +				mpi_rshift(t1, t1, 1);
> +				mpi_rshift(t2, t2, 1);
> +				mpi_rshift(t3, t3, 1);
> +			} else {
> +				if (mpi_test_bit(t1, 0))
> +					mpi_add(t1, t1, v);
> +				mpi_rshift(t1, t1, 1);
> +				mpi_rshift(t3, t3, 1);
> +			}
> +Y4:
> +			;
> +		} while (!mpi_test_bit(t3, 0)); /* while t3 is even */
> +
> +		if (!t3->sign) {
> +			mpi_set(u1, t1);
> +			if (!odd)
> +				mpi_set(u2, t2);
> +			mpi_set(u3, t3);
> +		} else {
> +			mpi_sub(v1, v, t1);
> +			sign =3D u->sign; u->sign =3D !u->sign;
> +			if (!odd)
> +				mpi_sub(v2, u, t2);
> +			u->sign =3D sign;
> +			sign =3D t3->sign; t3->sign =3D !t3->sign;
> +			mpi_set(v3, t3);
> +			t3->sign =3D sign;
> +		}
> +		mpi_sub(t1, u1, v1);
> +		if (!odd)
> +			mpi_sub(t2, u2, v2);
> +		mpi_sub(t3, u3, v3);
> +		if (t1->sign) {
> +			mpi_add(t1, t1, v);
> +			if (!odd)
> +				mpi_sub(t2, t2, u);
> +		}
> +	} while (mpi_cmp_ui(t3, 0)); /* while t3 !=3D 0 */
> +	/* mpi_lshift( u3, k ); */
> +	mpi_set(x, u1);
> +
> +	mpi_free(u1);
> +	mpi_free(v1);
> +	mpi_free(t1);
> +	if (!odd) {
> +		mpi_free(u2);
> +		mpi_free(v2);
> +		mpi_free(t2);
> +	}
> +	mpi_free(u3);
> +	mpi_free(v3);
> +	mpi_free(t3);
> +
> +	mpi_free(u);
> +	mpi_free(v);
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(mpi_invm);
> diff --git a/lib/mpi/mpi-mod.c b/lib/mpi/mpi-mod.c
> new file mode 100644
> index 000000000000..47bc59edd4ff
> --- /dev/null
> +++ b/lib/mpi/mpi-mod.c
> @@ -0,0 +1,155 @@
> +/* mpi-mod.c -  Modular reduction
> + * Copyright (C) 1998, 1999, 2001, 2002, 2003,
> + *               2007  Free Software Foundation, Inc.
> + *
> + * This file is part of Libgcrypt.
> + */
> +
> +
> +#include "mpi-internal.h"
> +#include "longlong.h"
> +
> +/* Context used with Barrett reduction.  */
> +struct barrett_ctx_s {
> +	MPI m;   /* The modulus - may not be modified. */
> +	int m_copied;   /* If true, M needs to be released.  */
> +	int k;
> +	MPI y;
> +	MPI r1;  /* Helper MPI. */
> +	MPI r2;  /* Helper MPI. */
> +	MPI r3;  /* Helper MPI allocated on demand. */
> +};
> +
> +
> +
> +void mpi_mod(MPI rem, MPI dividend, MPI divisor)
> +{
> +	mpi_fdiv_r(rem, dividend, divisor);
> +}
> +
> +/* This function returns a new context for Barrett based operations on
> + * the modulus M.  This context needs to be released using
> + * _gcry_mpi_barrett_free.  If COPY is true M will be transferred to
> + * the context and the user may change M.  If COPY is false, M may not
> + * be changed until gcry_mpi_barrett_free has been called.
> + */
> +mpi_barrett_t mpi_barrett_init(MPI m, int copy)
> +{
> +	mpi_barrett_t ctx;
> +	MPI tmp;
> +
> +	mpi_normalize(m);
> +	ctx =3D kcalloc(1, sizeof(*ctx), GFP_KERNEL);
> +
> +	if (copy) {
> +		ctx->m =3D mpi_copy(m);
> +		ctx->m_copied =3D 1;
> +	} else
> +		ctx->m =3D m;
> +
> +	ctx->k =3D mpi_get_nlimbs(m);
> +	tmp =3D mpi_alloc(ctx->k + 1);
> +
> +	/* Barrett precalculation: y =3D floor(b^(2k) / m). */
> +	mpi_set_ui(tmp, 1);
> +	mpi_lshift_limbs(tmp, 2 * ctx->k);
> +	mpi_fdiv_q(tmp, tmp, m);
> +
> +	ctx->y  =3D tmp;
> +	ctx->r1 =3D mpi_alloc(2 * ctx->k + 1);
> +	ctx->r2 =3D mpi_alloc(2 * ctx->k + 1);
> +
> +	return ctx;
> +}
> +
> +void mpi_barrett_free(mpi_barrett_t ctx)
> +{
> +	if (ctx) {
> +		mpi_free(ctx->y);
> +		mpi_free(ctx->r1);
> +		mpi_free(ctx->r2);
> +		if (ctx->r3)
> +			mpi_free(ctx->r3);
> +		if (ctx->m_copied)
> +			mpi_free(ctx->m);
> +		kfree(ctx);
> +	}
> +}
> +
> +
> +/* R =3D X mod M
> + *
> + * Using Barrett reduction.  Before using this function
> + * _gcry_mpi_barrett_init must have been called to do the
> + * precalculations.  CTX is the context created by this precalculation
> + * and also conveys M.  If the Barret reduction could no be done a
> + * straightforward reduction method is used.
> + *
> + * We assume that these conditions are met:
> + * Input:  x =3D(x_2k-1 ...x_0)_b
> + *     m =3D(m_k-1 ....m_0)_b	  with m_k-1 !=3D 0
> + * Output: r =3D x mod m
> + */
> +void mpi_mod_barrett(MPI r, MPI x, mpi_barrett_t ctx)
> +{
> +	MPI m =3D ctx->m;
> +	int k =3D ctx->k;
> +	MPI y =3D ctx->y;
> +	MPI r1 =3D ctx->r1;
> +	MPI r2 =3D ctx->r2;
> +	int sign;
> +
> +	mpi_normalize(x);
> +	if (mpi_get_nlimbs(x) > 2*k) {
> +		mpi_mod(r, x, m);
> +		return;
> +	}
> +
> +	sign =3D x->sign;
> +	x->sign =3D 0;
> +
> +	/* 1. q1 =3D floor( x / b^k-1)
> +	 *    q2 =3D q1 * y
> +	 *    q3 =3D floor( q2 / b^k+1 )
> +	 * Actually, we don't need qx, we can work direct on r2
> +	 */
> +	mpi_set(r2, x);
> +	mpi_rshift_limbs(r2, k-1);
> +	mpi_mul(r2, r2, y);
> +	mpi_rshift_limbs(r2, k+1);
> +
> +	/* 2. r1 =3D x mod b^k+1
> +	 *	r2 =3D q3 * m mod b^k+1
> +	 *	r  =3D r1 - r2
> +	 * 3. if r < 0 then  r =3D r + b^k+1
> +	 */
> +	mpi_set(r1, x);
> +	if (r1->nlimbs > k+1) /* Quick modulo operation.  */
> +		r1->nlimbs =3D k+1;
> +	mpi_mul(r2, r2, m);
> +	if (r2->nlimbs > k+1) /* Quick modulo operation. */
> +		r2->nlimbs =3D k+1;
> +	mpi_sub(r, r1, r2);
> +
> +	if (mpi_has_sign(r)) {
> +		if (!ctx->r3) {
> +			ctx->r3 =3D mpi_alloc(k + 2);
> +			mpi_set_ui(ctx->r3, 1);
> +			mpi_lshift_limbs(ctx->r3, k + 1);
> +		}
> +		mpi_add(r, r, ctx->r3);
> +	}
> +
> +	/* 4. while r >=3D m do r =3D r - m */
> +	while (mpi_cmp(r, m) >=3D 0)
> +		mpi_sub(r, r, m);
> +
> +	x->sign =3D sign;
> +}
> +
> +
> +void mpi_mul_barrett(MPI w, MPI u, MPI v, mpi_barrett_t ctx)
> +{
> +	mpi_mul(w, u, v);
> +	mpi_mod_barrett(w, w, ctx);
> +}
> diff --git a/lib/mpi/mpi-mul.c b/lib/mpi/mpi-mul.c
> new file mode 100644
> index 000000000000..587e6335cc12
> --- /dev/null
> +++ b/lib/mpi/mpi-mul.c
> @@ -0,0 +1,94 @@
> +/* mpi-mul.c  -  MPI functions
> + * Copyright (C) 1994, 1996, 1998, 2001, 2002,
> + *               2003 Free Software Foundation, Inc.
> + *
> + * This file is part of Libgcrypt.
> + *
> + * Note: This code is heavily based on the GNU MP Library.
> + *	 Actually it's the same code with only minor changes in the
> + *	 way the data is stored; this is to support the abstraction
> + *	 of an optional secure memory allocation which may be used
> + *	 to avoid revealing of sensitive data due to paging etc.
> + */
> +
> +#include "mpi-internal.h"
> +
> +void mpi_mul(MPI w, MPI u, MPI v)
> +{
> +	mpi_size_t usize, vsize, wsize;
> +	mpi_ptr_t up, vp, wp;
> +	mpi_limb_t cy;
> +	int usign, vsign, sign_product;
> +	int assign_wp =3D 0;
> +	mpi_ptr_t tmp_limb =3D NULL;
> +	unsigned int tmp_limb_nlimbs =3D 0;
> +
> +	if (u->nlimbs < v->nlimbs) {
> +		/* Swap U and V. */
> +		usize =3D v->nlimbs;
> +		usign =3D v->sign;
> +		up    =3D v->d;
> +		vsize =3D u->nlimbs;
> +		vsign =3D u->sign;
> +		vp    =3D u->d;
> +	} else {
> +		usize =3D u->nlimbs;
> +		usign =3D u->sign;
> +		up    =3D u->d;
> +		vsize =3D v->nlimbs;
> +		vsign =3D v->sign;
> +		vp    =3D v->d;
> +	}
> +	sign_product =3D usign ^ vsign;
> +	wp =3D w->d;
> +
> +	/* Ensure W has space enough to store the result.  */
> +	wsize =3D usize + vsize;
> +	if (w->alloced < wsize) {
> +		if (wp =3D=3D up || wp =3D=3D vp) {
> +			wp =3D mpi_alloc_limb_space(wsize);
> +			assign_wp =3D 1;
> +		} else {
> +			mpi_resize(w, wsize);
> +			wp =3D w->d;
> +		}
> +	} else { /* Make U and V not overlap with W.	*/
> +		if (wp =3D=3D up) {
> +			/* W and U are identical.  Allocate temporary space for U. */
> +			tmp_limb_nlimbs =3D usize;
> +			up =3D tmp_limb =3D mpi_alloc_limb_space(usize);
> +			/* Is V identical too?  Keep it identical with U.  */
> +			if (wp =3D=3D vp)
> +				vp =3D up;
> +			/* Copy to the temporary space.  */
> +			MPN_COPY(up, wp, usize);
> +		} else if (wp =3D=3D vp) {
> +			/* W and V are identical.  Allocate temporary space for V. */
> +			tmp_limb_nlimbs =3D vsize;
> +			vp =3D tmp_limb =3D mpi_alloc_limb_space(vsize);
> +			/* Copy to the temporary space.  */
> +			MPN_COPY(vp, wp, vsize);
> +		}
> +	}
> +
> +	if (!vsize)
> +		wsize =3D 0;
> +	else {
> +		mpihelp_mul(wp, up, usize, vp, vsize, &cy);
> +		wsize -=3D cy ? 0:1;
> +	}
> +
> +	if (assign_wp)
> +		mpi_assign_limb_space(w, wp, wsize);
> +	w->nlimbs =3D wsize;
> +	w->sign =3D sign_product;
> +	if (tmp_limb)
> +		mpi_free_limb_space(tmp_limb);
> +}
> +
> +void mpi_mulm(MPI w, MPI u, MPI v, MPI m)
> +{
> +	mpi_mul(w, u, v);
> +	mpi_tdiv_r(w, w, m);
> +}
> +EXPORT_SYMBOL_GPL(mpi_mulm);
> diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
> index eead4b339466..7ea225b2204f 100644
> --- a/lib/mpi/mpicoder.c
> +++ b/lib/mpi/mpicoder.c
> @@ -25,6 +25,7 @@
>  #include <linux/string.h>
>  #include "mpi-internal.h"
> =20
> +#define MAX_EXTERN_SCAN_BYTES (16*1024*1024)
>  #define MAX_EXTERN_MPI_BITS 16384
> =20
>  /**
> @@ -109,6 +110,112 @@ MPI mpi_read_from_buffer(const void *xbuffer, unsig=
ned *ret_nread)
>  }
>  EXPORT_SYMBOL_GPL(mpi_read_from_buffer);
> =20
> +/****************
> + * Fill the mpi VAL from the hex string in STR.
> + */
> +int mpi_fromstr(MPI val, const char *str)
> +{
> +	int sign =3D 0;
> +	int prepend_zero =3D 0;
> +	int i, j, c, c1, c2;
> +	unsigned int nbits, nbytes, nlimbs;
> +	mpi_limb_t a;
> +
> +	if (*str =3D=3D '-') {
> +		sign =3D 1;
> +		str++;
> +	}
> +
> +	/* Skip optional hex prefix.  */
> +	if (*str =3D=3D '0' && str[1] =3D=3D 'x')
> +		str +=3D 2;
> +
> +	nbits =3D strlen(str);
> +	if (nbits > MAX_EXTERN_SCAN_BYTES) {
> +		mpi_clear(val);
> +		return -EINVAL;
> +	}
> +	nbits *=3D 4;
> +	if ((nbits % 8))
> +		prepend_zero =3D 1;
> +
> +	nbytes =3D (nbits+7) / 8;
> +	nlimbs =3D (nbytes+BYTES_PER_MPI_LIMB-1) / BYTES_PER_MPI_LIMB;
> +
> +	if (val->alloced < nlimbs)
> +		mpi_resize(val, nlimbs);
> +
> +	i =3D BYTES_PER_MPI_LIMB - (nbytes % BYTES_PER_MPI_LIMB);
> +	i %=3D BYTES_PER_MPI_LIMB;
> +	j =3D val->nlimbs =3D nlimbs;
> +	val->sign =3D sign;
> +	for (; j > 0; j--) {
> +		a =3D 0;
> +		for (; i < BYTES_PER_MPI_LIMB; i++) {
> +			if (prepend_zero) {
> +				c1 =3D '0';
> +				prepend_zero =3D 0;
> +			} else
> +				c1 =3D *str++;
> +
> +			if (!c1) {
> +				mpi_clear(val);
> +				return -EINVAL;
> +			}
> +			c2 =3D *str++;
> +			if (!c2) {
> +				mpi_clear(val);
> +				return -EINVAL;
> +			}
> +			if (c1 >=3D '0' && c1 <=3D '9')
> +				c =3D c1 - '0';
> +			else if (c1 >=3D 'a' && c1 <=3D 'f')
> +				c =3D c1 - 'a' + 10;
> +			else if (c1 >=3D 'A' && c1 <=3D 'F')
> +				c =3D c1 - 'A' + 10;
> +			else {
> +				mpi_clear(val);
> +				return -EINVAL;
> +			}
> +			c <<=3D 4;
> +			if (c2 >=3D '0' && c2 <=3D '9')
> +				c |=3D c2 - '0';
> +			else if (c2 >=3D 'a' && c2 <=3D 'f')
> +				c |=3D c2 - 'a' + 10;
> +			else if (c2 >=3D 'A' && c2 <=3D 'F')
> +				c |=3D c2 - 'A' + 10;
> +			else {
> +				mpi_clear(val);
> +				return -EINVAL;
> +			}
> +			a <<=3D 8;
> +			a |=3D c;
> +		}
> +		i =3D 0;
> +		val->d[j-1] =3D a;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mpi_fromstr);
> +
> +MPI mpi_scanval(const char *string)
> +{
> +	MPI a;
> +
> +	a =3D mpi_alloc(0);
> +	if (!a)
> +		return NULL;
> +
> +	if (mpi_fromstr(a, string)) {
> +		mpi_free(a);
> +		return NULL;
> +	}
> +	mpi_normalize(a);
> +	return a;
> +}
> +EXPORT_SYMBOL_GPL(mpi_scanval);
> +
>  static int count_lzeros(MPI a)
>  {
>  	mpi_limb_t alimb;
> @@ -413,3 +520,232 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, =
unsigned int nbytes)
>  	return val;
>  }
>  EXPORT_SYMBOL_GPL(mpi_read_raw_from_sgl);
> +
> +/* Perform a two's complement operation on buffer P of size N bytes.  */
> +static void twocompl(unsigned char *p, unsigned int n)
> +{
> +	int i;
> +
> +	for (i =3D n-1; i >=3D 0 && !p[i]; i--)
> +		;
> +	if (i >=3D 0) {
> +		if ((p[i] & 0x01))
> +			p[i] =3D (((p[i] ^ 0xfe) | 0x01) & 0xff);
> +		else if ((p[i] & 0x02))
> +			p[i] =3D (((p[i] ^ 0xfc) | 0x02) & 0xfe);
> +		else if ((p[i] & 0x04))
> +			p[i] =3D (((p[i] ^ 0xf8) | 0x04) & 0xfc);
> +		else if ((p[i] & 0x08))
> +			p[i] =3D (((p[i] ^ 0xf0) | 0x08) & 0xf8);
> +		else if ((p[i] & 0x10))
> +			p[i] =3D (((p[i] ^ 0xe0) | 0x10) & 0xf0);
> +		else if ((p[i] & 0x20))
> +			p[i] =3D (((p[i] ^ 0xc0) | 0x20) & 0xe0);
> +		else if ((p[i] & 0x40))
> +			p[i] =3D (((p[i] ^ 0x80) | 0x40) & 0xc0);
> +		else
> +			p[i] =3D 0x80;
> +
> +		for (i--; i >=3D 0; i--)
> +			p[i] ^=3D 0xff;
> +	}
> +}
> +
> +int mpi_print(enum gcry_mpi_format format, unsigned char *buffer,
> +			size_t buflen, size_t *nwritten, MPI a)
> +{
> +	unsigned int nbits =3D mpi_get_nbits(a);
> +	size_t len;
> +	size_t dummy_nwritten;
> +	int negative;
> +
> +	if (!nwritten)
> +		nwritten =3D &dummy_nwritten;
> +
> +	/* Libgcrypt does no always care to set clear the sign if the value
> +	 * is 0.  For printing this is a bit of a surprise, in particular
> +	 * because if some of the formats don't support negative numbers but
> +	 * should be able to print a zero.  Thus we need this extra test
> +	 * for a negative number.
> +	 */
> +	if (a->sign && mpi_cmp_ui(a, 0))
> +		negative =3D 1;
> +	else
> +		negative =3D 0;
> +
> +	len =3D buflen;
> +	*nwritten =3D 0;
> +	if (format =3D=3D GCRYMPI_FMT_STD) {
> +		unsigned char *tmp;
> +		int extra =3D 0;
> +		unsigned int n;
> +
> +		tmp =3D mpi_get_buffer(a, &n, NULL);
> +		if (!tmp)
> +			return -EINVAL;
> +
> +		if (negative) {
> +			twocompl(tmp, n);
> +			if (!(*tmp & 0x80)) {
> +				/* Need to extend the sign.  */
> +				n++;
> +				extra =3D 2;
> +			}
> +		} else if (n && (*tmp & 0x80)) {
> +			/* Positive but the high bit of the returned buffer is set.
> +			 * Thus we need to print an extra leading 0x00 so that the
> +			 * output is interpreted as a positive number.
> +			 */
> +			n++;
> +			extra =3D 1;
> +		}
> +
> +		if (buffer && n > len) {
> +			/* The provided buffer is too short. */
> +			kfree(tmp);
> +			return -E2BIG;
> +		}
> +		if (buffer) {
> +			unsigned char *s =3D buffer;
> +
> +			if (extra =3D=3D 1)
> +				*s++ =3D 0;
> +			else if (extra)
> +				*s++ =3D 0xff;
> +			memcpy(s, tmp, n-!!extra);
> +		}
> +		kfree(tmp);
> +		*nwritten =3D n;
> +		return 0;
> +	} else if (format =3D=3D GCRYMPI_FMT_USG) {
> +		unsigned int n =3D (nbits + 7)/8;
> +
> +		/* Note:  We ignore the sign for this format.  */
> +		/* FIXME: for performance reasons we should put this into
> +		 * mpi_aprint because we can then use the buffer directly.
> +		 */
> +
> +		if (buffer && n > len)
> +			return -E2BIG;
> +		if (buffer) {
> +			unsigned char *tmp;
> +
> +			tmp =3D mpi_get_buffer(a, &n, NULL);
> +			if (!tmp)
> +				return -EINVAL;
> +			memcpy(buffer, tmp, n);
> +			kfree(tmp);
> +		}
> +		*nwritten =3D n;
> +		return 0;
> +	} else if (format =3D=3D GCRYMPI_FMT_PGP) {
> +		unsigned int n =3D (nbits + 7)/8;
> +
> +		/* The PGP format can only handle unsigned integers.  */
> +		if (negative)
> +			return -EINVAL;
> +
> +		if (buffer && n+2 > len)
> +			return -E2BIG;
> +
> +		if (buffer) {
> +			unsigned char *tmp;
> +			unsigned char *s =3D buffer;
> +
> +			s[0] =3D nbits >> 8;
> +			s[1] =3D nbits;
> +
> +			tmp =3D mpi_get_buffer(a, &n, NULL);
> +			if (!tmp)
> +				return -EINVAL;
> +			memcpy(s+2, tmp, n);
> +			kfree(tmp);
> +		}
> +		*nwritten =3D n+2;
> +		return 0;
> +	} else if (format =3D=3D GCRYMPI_FMT_SSH) {
> +		unsigned char *tmp;
> +		int extra =3D 0;
> +		unsigned int n;
> +
> +		tmp =3D mpi_get_buffer(a, &n, NULL);
> +		if (!tmp)
> +			return -EINVAL;
> +
> +		if (negative) {
> +			twocompl(tmp, n);
> +			if (!(*tmp & 0x80)) {
> +				/* Need to extend the sign.  */
> +				n++;
> +				extra =3D 2;
> +			}
> +		} else if (n && (*tmp & 0x80)) {
> +			n++;
> +			extra =3D 1;
> +		}
> +
> +		if (buffer && n+4 > len) {
> +			kfree(tmp);
> +			return -E2BIG;
> +		}
> +
> +		if (buffer) {
> +			unsigned char *s =3D buffer;
> +
> +			*s++ =3D n >> 24;
> +			*s++ =3D n >> 16;
> +			*s++ =3D n >> 8;
> +			*s++ =3D n;
> +			if (extra =3D=3D 1)
> +				*s++ =3D 0;
> +			else if (extra)
> +				*s++ =3D 0xff;
> +			memcpy(s, tmp, n-!!extra);
> +		}
> +		kfree(tmp);
> +		*nwritten =3D 4+n;
> +		return 0;
> +	} else if (format =3D=3D GCRYMPI_FMT_HEX) {
> +		unsigned char *tmp;
> +		int i;
> +		int extra =3D 0;
> +		unsigned int n =3D 0;
> +
> +		tmp =3D mpi_get_buffer(a, &n, NULL);
> +		if (!tmp)
> +			return -EINVAL;
> +		if (!n || (*tmp & 0x80))
> +			extra =3D 2;
> +
> +		if (buffer && 2*n + extra + negative + 1 > len) {
> +			kfree(tmp);
> +			return -E2BIG;
> +		}
> +		if (buffer) {
> +			unsigned char *s =3D buffer;
> +
> +			if (negative)
> +				*s++ =3D '-';
> +			if (extra) {
> +				*s++ =3D '0';
> +				*s++ =3D '0';
> +			}
> +
> +			for (i =3D 0; i < n; i++) {
> +				unsigned int c =3D tmp[i];
> +
> +				*s++ =3D (c >> 4) < 10 ? '0'+(c>>4) : 'A'+(c>>4)-10;
> +				c &=3D 15;
> +				*s++ =3D c < 10 ? '0'+c : 'A'+c-10;
> +			}
> +			*s++ =3D 0;
> +			*nwritten =3D s - buffer;
> +		} else {
> +			*nwritten =3D 2*n + extra + negative + 1;
> +		}
> +		kfree(tmp);
> +		return 0;
> +	} else
> +		return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(mpi_print);
> diff --git a/lib/mpi/mpih-div.c b/lib/mpi/mpih-div.c
> index 913a519eb005..182a656a1ba0 100644
> --- a/lib/mpi/mpih-div.c
> +++ b/lib/mpi/mpih-div.c
> @@ -24,6 +24,150 @@
>  #define UDIV_TIME UMUL_TIME
>  #endif
> =20
> +
> +mpi_limb_t
> +mpihelp_mod_1(mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
> +			mpi_limb_t divisor_limb)
> +{
> +	mpi_size_t i;
> +	mpi_limb_t n1, n0, r;
> +	mpi_limb_t dummy;
> +
> +	/* Botch: Should this be handled at all?  Rely on callers?	*/
> +	if (!dividend_size)
> +		return 0;
> +
> +	/* If multiplication is much faster than division, and the
> +	 * dividend is large, pre-invert the divisor, and use
> +	 * only multiplications in the inner loop.
> +	 *
> +	 * This test should be read:
> +	 *	 Does it ever help to use udiv_qrnnd_preinv?
> +	 *	   && Does what we save compensate for the inversion overhead?
> +	 */
> +	if (UDIV_TIME > (2 * UMUL_TIME + 6)
> +			&& (UDIV_TIME - (2 * UMUL_TIME + 6)) * dividend_size > UDIV_TIME) {
> +		int normalization_steps;
> +
> +		normalization_steps =3D count_leading_zeros(divisor_limb);
> +		if (normalization_steps) {
> +			mpi_limb_t divisor_limb_inverted;
> +
> +			divisor_limb <<=3D normalization_steps;
> +
> +			/* Compute (2**2N - 2**N * DIVISOR_LIMB) / DIVISOR_LIMB.  The
> +			 * result is a (N+1)-bit approximation to 1/DIVISOR_LIMB, with the
> +			 * most significant bit (with weight 2**N) implicit.
> +			 *
> +			 * Special case for DIVISOR_LIMB =3D=3D 100...000.
> +			 */
> +			if (!(divisor_limb << 1))
> +				divisor_limb_inverted =3D ~(mpi_limb_t)0;
> +			else
> +				udiv_qrnnd(divisor_limb_inverted, dummy,
> +						-divisor_limb, 0, divisor_limb);
> +
> +			n1 =3D dividend_ptr[dividend_size - 1];
> +			r =3D n1 >> (BITS_PER_MPI_LIMB - normalization_steps);
> +
> +			/* Possible optimization:
> +			 * if (r =3D=3D 0
> +			 * && divisor_limb > ((n1 << normalization_steps)
> +			 *		       | (dividend_ptr[dividend_size - 2] >> ...)))
> +			 * ...one division less...
> +			 */
> +			for (i =3D dividend_size - 2; i >=3D 0; i--) {
> +				n0 =3D dividend_ptr[i];
> +				UDIV_QRNND_PREINV(dummy, r, r,
> +						((n1 << normalization_steps)
> +						 | (n0 >> (BITS_PER_MPI_LIMB - normalization_steps))),
> +						divisor_limb, divisor_limb_inverted);
> +				n1 =3D n0;
> +			}
> +			UDIV_QRNND_PREINV(dummy, r, r,
> +					n1 << normalization_steps,
> +					divisor_limb, divisor_limb_inverted);
> +			return r >> normalization_steps;
> +		} else {
> +			mpi_limb_t divisor_limb_inverted;
> +
> +			/* Compute (2**2N - 2**N * DIVISOR_LIMB) / DIVISOR_LIMB.  The
> +			 * result is a (N+1)-bit approximation to 1/DIVISOR_LIMB, with the
> +			 * most significant bit (with weight 2**N) implicit.
> +			 *
> +			 * Special case for DIVISOR_LIMB =3D=3D 100...000.
> +			 */
> +			if (!(divisor_limb << 1))
> +				divisor_limb_inverted =3D ~(mpi_limb_t)0;
> +			else
> +				udiv_qrnnd(divisor_limb_inverted, dummy,
> +						-divisor_limb, 0, divisor_limb);
> +
> +			i =3D dividend_size - 1;
> +			r =3D dividend_ptr[i];
> +
> +			if (r >=3D divisor_limb)
> +				r =3D 0;
> +			else
> +				i--;
> +
> +			for ( ; i >=3D 0; i--) {
> +				n0 =3D dividend_ptr[i];
> +				UDIV_QRNND_PREINV(dummy, r, r,
> +						n0, divisor_limb, divisor_limb_inverted);
> +			}
> +			return r;
> +		}
> +	} else {
> +		if (UDIV_NEEDS_NORMALIZATION) {
> +			int normalization_steps;
> +
> +			normalization_steps =3D count_leading_zeros(divisor_limb);
> +			if (normalization_steps) {
> +				divisor_limb <<=3D normalization_steps;
> +
> +				n1 =3D dividend_ptr[dividend_size - 1];
> +				r =3D n1 >> (BITS_PER_MPI_LIMB - normalization_steps);
> +
> +				/* Possible optimization:
> +				 * if (r =3D=3D 0
> +				 * && divisor_limb > ((n1 << normalization_steps)
> +				 *		   | (dividend_ptr[dividend_size - 2] >> ...)))
> +				 * ...one division less...
> +				 */
> +				for (i =3D dividend_size - 2; i >=3D 0; i--) {
> +					n0 =3D dividend_ptr[i];
> +					udiv_qrnnd(dummy, r, r,
> +						((n1 << normalization_steps)
> +						 | (n0 >> (BITS_PER_MPI_LIMB - normalization_steps))),
> +						divisor_limb);
> +					n1 =3D n0;
> +				}
> +				udiv_qrnnd(dummy, r, r,
> +						n1 << normalization_steps,
> +						divisor_limb);
> +				return r >> normalization_steps;
> +			}
> +		}
> +		/* No normalization needed, either because udiv_qrnnd doesn't require
> +		 * it, or because DIVISOR_LIMB is already normalized.
> +		 */
> +		i =3D dividend_size - 1;
> +		r =3D dividend_ptr[i];
> +
> +		if (r >=3D divisor_limb)
> +			r =3D 0;
> +		else
> +			i--;
> +
> +		for (; i >=3D 0; i--) {
> +			n0 =3D dividend_ptr[i];
> +			udiv_qrnnd(dummy, r, r, n0, divisor_limb);
> +		}
> +		return r;
> +	}
> +}
> +
>  /* Divide num (NP/NSIZE) by den (DP/DSIZE) and write
>   * the NSIZE-DSIZE least significant quotient limbs at QP
>   * and the DSIZE long remainder at NP.	If QEXTRA_LIMBS is
> @@ -221,3 +365,153 @@ mpihelp_divrem(mpi_ptr_t qp, mpi_size_t qextra_limb=
s,
> =20
>  	return most_significant_q_limb;
>  }
> +
> +/****************
> + * Divide (DIVIDEND_PTR,,DIVIDEND_SIZE) by DIVISOR_LIMB.
> + * Write DIVIDEND_SIZE limbs of quotient at QUOT_PTR.
> + * Return the single-limb remainder.
> + * There are no constraints on the value of the divisor.
> + *
> + * QUOT_PTR and DIVIDEND_PTR might point to the same limb.
> + */
> +
> +mpi_limb_t
> +mpihelp_divmod_1(mpi_ptr_t quot_ptr,
> +		mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
> +		mpi_limb_t divisor_limb)
> +{
> +	mpi_size_t i;
> +	mpi_limb_t n1, n0, r;
> +	mpi_limb_t dummy;
> +
> +	if (!dividend_size)
> +		return 0;
> +
> +	/* If multiplication is much faster than division, and the
> +	 * dividend is large, pre-invert the divisor, and use
> +	 * only multiplications in the inner loop.
> +	 *
> +	 * This test should be read:
> +	 * Does it ever help to use udiv_qrnnd_preinv?
> +	 * && Does what we save compensate for the inversion overhead?
> +	 */
> +	if (UDIV_TIME > (2 * UMUL_TIME + 6)
> +			&& (UDIV_TIME - (2 * UMUL_TIME + 6)) * dividend_size > UDIV_TIME) {
> +		int normalization_steps;
> +
> +		normalization_steps =3D count_leading_zeros(divisor_limb);
> +		if (normalization_steps) {
> +			mpi_limb_t divisor_limb_inverted;
> +
> +			divisor_limb <<=3D normalization_steps;
> +
> +			/* Compute (2**2N - 2**N * DIVISOR_LIMB) / DIVISOR_LIMB.  The
> +			 * result is a (N+1)-bit approximation to 1/DIVISOR_LIMB, with the
> +			 * most significant bit (with weight 2**N) implicit.
> +			 */
> +			/* Special case for DIVISOR_LIMB =3D=3D 100...000.  */
> +			if (!(divisor_limb << 1))
> +				divisor_limb_inverted =3D ~(mpi_limb_t)0;
> +			else
> +				udiv_qrnnd(divisor_limb_inverted, dummy,
> +						-divisor_limb, 0, divisor_limb);
> +
> +			n1 =3D dividend_ptr[dividend_size - 1];
> +			r =3D n1 >> (BITS_PER_MPI_LIMB - normalization_steps);
> +
> +			/* Possible optimization:
> +			 * if (r =3D=3D 0
> +			 * && divisor_limb > ((n1 << normalization_steps)
> +			 *		       | (dividend_ptr[dividend_size - 2] >> ...)))
> +			 * ...one division less...
> +			 */
> +			for (i =3D dividend_size - 2; i >=3D 0; i--) {
> +				n0 =3D dividend_ptr[i];
> +				UDIV_QRNND_PREINV(quot_ptr[i + 1], r, r,
> +						((n1 << normalization_steps)
> +						 | (n0 >> (BITS_PER_MPI_LIMB - normalization_steps))),
> +						divisor_limb, divisor_limb_inverted);
> +				n1 =3D n0;
> +			}
> +			UDIV_QRNND_PREINV(quot_ptr[0], r, r,
> +					n1 << normalization_steps,
> +					divisor_limb, divisor_limb_inverted);
> +			return r >> normalization_steps;
> +		} else {
> +			mpi_limb_t divisor_limb_inverted;
> +
> +			/* Compute (2**2N - 2**N * DIVISOR_LIMB) / DIVISOR_LIMB.  The
> +			 * result is a (N+1)-bit approximation to 1/DIVISOR_LIMB, with the
> +			 * most significant bit (with weight 2**N) implicit.
> +			 */
> +			/* Special case for DIVISOR_LIMB =3D=3D 100...000.  */
> +			if (!(divisor_limb << 1))
> +				divisor_limb_inverted =3D ~(mpi_limb_t) 0;
> +			else
> +				udiv_qrnnd(divisor_limb_inverted, dummy,
> +						-divisor_limb, 0, divisor_limb);
> +
> +			i =3D dividend_size - 1;
> +			r =3D dividend_ptr[i];
> +
> +			if (r >=3D divisor_limb)
> +				r =3D 0;
> +			else
> +				quot_ptr[i--] =3D 0;
> +
> +			for ( ; i >=3D 0; i--) {
> +				n0 =3D dividend_ptr[i];
> +				UDIV_QRNND_PREINV(quot_ptr[i], r, r,
> +						n0, divisor_limb, divisor_limb_inverted);
> +			}
> +			return r;
> +		}
> +	} else {
> +		if (UDIV_NEEDS_NORMALIZATION) {
> +			int normalization_steps;
> +
> +			normalization_steps =3D count_leading_zeros(divisor_limb);
> +			if (normalization_steps) {
> +				divisor_limb <<=3D normalization_steps;
> +
> +				n1 =3D dividend_ptr[dividend_size - 1];
> +				r =3D n1 >> (BITS_PER_MPI_LIMB - normalization_steps);
> +
> +				/* Possible optimization:
> +				 * if (r =3D=3D 0
> +				 * && divisor_limb > ((n1 << normalization_steps)
> +				 *		   | (dividend_ptr[dividend_size - 2] >> ...)))
> +				 * ...one division less...
> +				 */
> +				for (i =3D dividend_size - 2; i >=3D 0; i--) {
> +					n0 =3D dividend_ptr[i];
> +					udiv_qrnnd(quot_ptr[i + 1], r, r,
> +						((n1 << normalization_steps)
> +						 | (n0 >> (BITS_PER_MPI_LIMB - normalization_steps))),
> +						divisor_limb);
> +					n1 =3D n0;
> +				}
> +				udiv_qrnnd(quot_ptr[0], r, r,
> +						n1 << normalization_steps,
> +						divisor_limb);
> +				return r >> normalization_steps;
> +			}
> +		}
> +		/* No normalization needed, either because udiv_qrnnd doesn't require
> +		 * it, or because DIVISOR_LIMB is already normalized.
> +		 */
> +		i =3D dividend_size - 1;
> +		r =3D dividend_ptr[i];
> +
> +		if (r >=3D divisor_limb)
> +			r =3D 0;
> +		else
> +			quot_ptr[i--] =3D 0;
> +
> +		for (; i >=3D 0; i--) {
> +			n0 =3D dividend_ptr[i];
> +			udiv_qrnnd(quot_ptr[i], r, r, n0, divisor_limb);
> +		}
> +		return r;
> +	}
> +}
> diff --git a/lib/mpi/mpih-mul.c b/lib/mpi/mpih-mul.c
> index a93647564054..e5f1c84e3c48 100644
> --- a/lib/mpi/mpih-mul.c
> +++ b/lib/mpi/mpih-mul.c
> @@ -317,6 +317,31 @@ mpih_sqr_n(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t=
 size, mpi_ptr_t tspace)
>  	}
>  }
> =20
> +
> +void mpihelp_mul_n(mpi_ptr_t prodp,
> +		mpi_ptr_t up, mpi_ptr_t vp, mpi_size_t size)
> +{
> +	if (up =3D=3D vp) {
> +		if (size < KARATSUBA_THRESHOLD)
> +			mpih_sqr_n_basecase(prodp, up, size);
> +		else {
> +			mpi_ptr_t tspace;
> +			tspace =3D mpi_alloc_limb_space(2 * size);
> +			mpih_sqr_n(prodp, up, size, tspace);
> +			mpi_free_limb_space(tspace);
> +		}
> +	} else {
> +		if (size < KARATSUBA_THRESHOLD)
> +			mul_n_basecase(prodp, up, vp, size);
> +		else {
> +			mpi_ptr_t tspace;
> +			tspace =3D mpi_alloc_limb_space(2 * size);
> +			mul_n(prodp, up, vp, size, tspace);
> +			mpi_free_limb_space(tspace);
> +		}
> +	}
> +}
> +
>  int
>  mpihelp_mul_karatsuba_case(mpi_ptr_t prodp,
>  			   mpi_ptr_t up, mpi_size_t usize,
> diff --git a/lib/mpi/mpiutil.c b/lib/mpi/mpiutil.c
> index 20ed0f766787..e4046f74f336 100644
> --- a/lib/mpi/mpiutil.c
> +++ b/lib/mpi/mpiutil.c
> @@ -20,6 +20,63 @@
> =20
>  #include "mpi-internal.h"
> =20
> +/* Constants allocated right away at startup.  */
> +static MPI constants[MPI_NUMBER_OF_CONSTANTS];
> +
> +/* Initialize the MPI subsystem.  This is called early and allows to
> + * do some initialization without taking care of threading issues.
> + */
> +static int __init mpi_init(void)
> +{
> +	int idx;
> +	unsigned long value;
> +
> +	for (idx =3D 0; idx < MPI_NUMBER_OF_CONSTANTS; idx++) {
> +		switch (idx) {
> +		case MPI_C_ZERO:
> +			value =3D 0;
> +			break;
> +		case MPI_C_ONE:
> +			value =3D 1;
> +			break;
> +		case MPI_C_TWO:
> +			value =3D 2;
> +			break;
> +		case MPI_C_THREE:
> +			value =3D 3;
> +			break;
> +		case MPI_C_FOUR:
> +			value =3D 4;
> +			break;
> +		case MPI_C_EIGHT:
> +			value =3D 8;
> +			break;
> +		default:
> +			pr_err("MPI: invalid mpi_const selector %d\n", idx);
> +			return -EFAULT;
> +		}
> +		constants[idx] =3D mpi_alloc_set_ui(value);
> +		constants[idx]->flags =3D (16|32);
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(mpi_init);
> +
> +/* Return a constant MPI descripbed by NO which is one of the
> + * MPI_C_xxx macros.  There is no need to copy this returned value; it
> + * may be used directly.
> + */
> +MPI mpi_const(enum gcry_mpi_constants no)
> +{
> +	if ((int)no < 0 || no > MPI_NUMBER_OF_CONSTANTS)
> +		pr_err("MPI: invalid mpi_const selector %d\n", no);
> +	if (!constants[no])
> +		pr_err("MPI: MPI subsystem not initialized\n");
> +	return constants[no];
> +}
> +EXPORT_SYMBOL_GPL(mpi_const);
> +
>  /****************
>   * Note:  It was a bad idea to use the number of limbs to allocate
>   *	  because on a alpha the limbs are large but we normally need
> @@ -106,6 +163,15 @@ int mpi_resize(MPI a, unsigned nlimbs)
>  	return 0;
>  }
> =20
> +void mpi_clear(MPI a)
> +{
> +	if (!a)
> +		return;
> +	a->nlimbs =3D 0;
> +	a->flags =3D 0;
> +}
> +EXPORT_SYMBOL_GPL(mpi_clear);
> +
>  void mpi_free(MPI a)
>  {
>  	if (!a)
> @@ -122,5 +188,143 @@ void mpi_free(MPI a)
>  }
>  EXPORT_SYMBOL_GPL(mpi_free);
> =20
> +/****************
> + * Note: This copy function should not interpret the MPI
> + *	 but copy it transparently.
> + */
> +MPI mpi_copy(MPI a)
> +{
> +	int i;
> +	MPI b;
> +
> +	if (a) {
> +		b =3D mpi_alloc(a->nlimbs);
> +		b->nlimbs =3D a->nlimbs;
> +		b->sign =3D a->sign;
> +		b->flags =3D a->flags;
> +		b->flags &=3D ~(16|32); /* Reset the immutable and constant flags. */
> +		for (i =3D 0; i < b->nlimbs; i++)
> +			b->d[i] =3D a->d[i];
> +	} else
> +		b =3D NULL;
> +	return b;
> +}
> +
> +/****************
> + * This function allocates an MPI which is optimized to hold
> + * a value as large as the one given in the argument and allocates it
> + * with the same flags as A.
> + */
> +MPI mpi_alloc_like(MPI a)
> +{
> +	MPI b;
> +
> +	if (a) {
> +		b =3D mpi_alloc(a->nlimbs);
> +		b->nlimbs =3D 0;
> +		b->sign =3D 0;
> +		b->flags =3D a->flags;
> +	} else
> +		b =3D NULL;
> +
> +	return b;
> +}
> +
> +
> +/* Set U into W and release U.  If W is NULL only U will be released. */
> +void mpi_snatch(MPI w, MPI u)
> +{
> +	if (w) {
> +		mpi_assign_limb_space(w, u->d, u->alloced);
> +		w->nlimbs =3D u->nlimbs;
> +		w->sign   =3D u->sign;
> +		w->flags  =3D u->flags;
> +		u->alloced =3D 0;
> +		u->nlimbs =3D 0;
> +		u->d =3D NULL;
> +	}
> +	mpi_free(u);
> +}
> +
> +
> +MPI mpi_set(MPI w, MPI u)
> +{
> +	mpi_ptr_t wp, up;
> +	mpi_size_t usize =3D u->nlimbs;
> +	int usign =3D u->sign;
> +
> +	if (!w)
> +		w =3D mpi_alloc(mpi_get_nlimbs(u));
> +	RESIZE_IF_NEEDED(w, usize);
> +	wp =3D w->d;
> +	up =3D u->d;
> +	MPN_COPY(wp, up, usize);
> +	w->nlimbs =3D usize;
> +	w->flags =3D u->flags;
> +	w->flags &=3D ~(16|32); /* Reset the immutable and constant flags.  */
> +	w->sign =3D usign;
> +	return w;
> +}
> +EXPORT_SYMBOL_GPL(mpi_set);
> +
> +MPI mpi_set_ui(MPI w, unsigned long u)
> +{
> +	if (!w)
> +		w =3D mpi_alloc(1);
> +	/* FIXME: If U is 0 we have no need to resize and thus possible
> +	 * allocating the the limbs.
> +	 */
> +	RESIZE_IF_NEEDED(w, 1);
> +	w->d[0] =3D u;
> +	w->nlimbs =3D u ? 1 : 0;
> +	w->sign =3D 0;
> +	w->flags =3D 0;
> +	return w;
> +}
> +EXPORT_SYMBOL_GPL(mpi_set_ui);
> +
> +MPI mpi_alloc_set_ui(unsigned long u)
> +{
> +	MPI w =3D mpi_alloc(1);
> +	w->d[0] =3D u;
> +	w->nlimbs =3D u ? 1 : 0;
> +	w->sign =3D 0;
> +	return w;
> +}
> +
> +/****************
> + * Swap the value of A and B, when SWAP is 1.
> + * Leave the value when SWAP is 0.
> + * This implementation should be constant-time regardless of SWAP.
> + */
> +void mpi_swap_cond(MPI a, MPI b, unsigned long swap)
> +{
> +	mpi_size_t i;
> +	mpi_size_t nlimbs;
> +	mpi_limb_t mask =3D ((mpi_limb_t)0) - swap;
> +	mpi_limb_t x;
> +
> +	if (a->alloced > b->alloced)
> +		nlimbs =3D b->alloced;
> +	else
> +		nlimbs =3D a->alloced;
> +	if (a->nlimbs > nlimbs || b->nlimbs > nlimbs)
> +		return;
> +
> +	for (i =3D 0; i < nlimbs; i++) {
> +		x =3D mask & (a->d[i] ^ b->d[i]);
> +		a->d[i] =3D a->d[i] ^ x;
> +		b->d[i] =3D b->d[i] ^ x;
> +	}
> +
> +	x =3D mask & (a->nlimbs ^ b->nlimbs);
> +	a->nlimbs =3D a->nlimbs ^ x;
> +	b->nlimbs =3D b->nlimbs ^ x;
> +
> +	x =3D mask & (a->sign ^ b->sign);
> +	a->sign =3D a->sign ^ x;
> +	b->sign =3D b->sign ^ x;
> +}
> +
>  MODULE_DESCRIPTION("Multiprecision maths library");
>  MODULE_LICENSE("GPL");
> --=20
> 2.17.1
>=20

--=20
Regards,
Marcelo


--4mfzr6qn7hyblft7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEExJjLjAfVL0XbfEr56e82LoessAkFAl8IaSIACgkQ6e82Loes
sAnssgwAolDa1bmqwhYe3IlgNJRT1MPL1j8ct5N6wPvCHC88kHZbL+i2s4FT/yaS
FCcAtpKmYGL3iOyadW9pvI2RTIgyBClvt1b5NlKIw8Gsf+laKI7G3xOkrO5ocO1T
JctUwwfs02lzAEdYCLE2K++UmGoZX4+xmTaiIqHD9ywr2mGkfXNZWMtpwPu8SM/c
D3CuFRFzRFxWv/CZoKF7LdXadQxnXhVXAng5xr/9eQGskmIdQO7RsYFoLF+bcSc1
mrVhe+tFyNtrmbAixlrH3l4SRbN1/lJx6hccv9KonQrzMBMmJUuDxMoFrGRjlRwU
uFmo8uIdWEL2JY1fdPMgtHCpT+KVKmmlDSGlDZGhXeGUxSBa1YzpSiY1nBzaRaP6
jPLLJOgzT9f/YGZfwWil5mjvgWM7uaiNG2XYJtzQL7pP7+YYUaVtIU1F4MbUhzlJ
wIMmyIbvOl985JdIk469/fR9Wsj5tBJOXzMbAnMKUcoHBZeogXWTa9K+5iYVHz+V
+OBCfXTg
=ky6W
-----END PGP SIGNATURE-----

--4mfzr6qn7hyblft7--
